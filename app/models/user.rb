class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :documents
  has_many :mail_reminder

  def to_s
    email
  end

  def pay_via_paypal(params)
    payment = PayPal::SDK::REST::Payment.new({
      :intent => "sale",
      :payer => {
        :payment_method => "credit_card",
        :funding_instruments => [{
          :credit_card => {
            :type => params[:credit_card_type],
            :number => params[:credit_card_number],
            :expire_month => params[:credit_card_expire_month],
            :expire_year => params[:credit_card_expire_year],
            :cvv2 => params[:credit_card_cvv2],
            :first_name => params[:credit_card_first_name],
            :last_name => params[:credit_card_last_name],
            :billing_address => {
              :line1 => params[:billing_address],
              :city => params[:billing_city],
              :state => params[:billing_state],
              :postal_code => params[:billing_postal_code],
              :country_code => params[:billing_country_code] }}}]},
      :transactions => [{
        :item_list => {
          :items => [{
            :name => "item",
            :sku => "item",
            :price => '1',
            :currency => "USD",
            :quantity => 1 }]},
        :amount => {
          :total => '1.00',
          :currency => 'USD' },
        :description => 'Single paypal payment.' }]})

    if payment.create
      self.paypal_payment_id = payment.id
      self.save
    else
      error = payment.error['details'].map { |d| "#{d['field']}: #{d['issue']}" }.join '<br/>'
      self.errors.add :base, error
    end
  end

  def bind_sub_document(document_id, next_document)
    documents.find(document_id).next_document = next_document
  end

  def create_mail_reminder!(reminder_type)
    if !mail_reminder.map{ |item| item.reminder_type }.include? reminder_type
      mail_reminder.create(:reminder_type => reminder_type)
    end
  end

  def create_document(template_id)
    documents.where(:template_id => template_id).destroy_all
    template = Template.find(template_id)
    template.documents.create(:template_name => template.name, :user_id => id)
  end
end
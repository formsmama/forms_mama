class PaypalPaymentsController < ApplicationController
  layout false

  def new
  end

  def create
    current_user.pay_via_paypal params
  end
end

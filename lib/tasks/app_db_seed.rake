namespace :app do
  namespace :db do
    task :seed => :environment do
      Dir.glob('db/documents/*.rb').each do |filename|
        load(filename) if File.exist?(filename)
      end
    end
  end
end
# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")

namespace :app do
  namespace :db do
    desc %q{
    Makes DB empty (no data, just tables ready for seeding)
    Options list:
      clear_all => clear all DB tables; OPTIONAL; Default is false;

    Examples:
      rake app:db:clear
      rake app:db:clear clear_all=true
    }

    task :clear do
      CLEAR_ALL = ENV.fetch 'clear_all', false

      DatabaseCleaner.strategy = :truncation, { :except => CLEAR_ALL ? [] : %w[users] }
      DatabaseCleaner.clean
    end
  end
end

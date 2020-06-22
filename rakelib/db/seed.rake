require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

namespace :db do
  desc 'Seeds database with data'
  task :seed do
    require_relative '../../config/application_loader'
    ApplicationLoader.load_app!

    eval(File.read(Application.root.concat('/db/seeds.rb')))
  end
end

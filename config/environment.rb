require 'bundler'
Bundler.require

require 'open-uri'
require 'net/http'
require 'JSON'
require "colorize"

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.logger.level = 1

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'



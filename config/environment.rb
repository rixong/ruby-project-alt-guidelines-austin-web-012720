require 'bundler'
Bundler.require

require 'open-uri'
require 'net/http'
require 'JSON'
require "colorize"
require 'io/console'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'



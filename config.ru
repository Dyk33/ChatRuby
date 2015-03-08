$:.unshift File.expand_path("../", __FILE__)
require './myapp'
require 'sass'
run Sinatra::Application



$:.unshift File.expand_path("../", __FILE__)
require 'rubygems'
require './myapp'
require 'sass'
run Sinatra::Application



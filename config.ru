$:.unshift File.expand_path("../", __FILE__)
require 'rubygems'
require 'sass'
require 'sinatra'
require 'rack'
require './myapp'
run Sinatra::Application



#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

#ORM - object relational mapper (mapping) - связка ООП с реляционными БД.
#tux - консоль для active record
#barber.create - создает сразу в БД
#b = barber.new - создает объект в памяти, затем b.save сохраняет в бд

set :database, {adapter: "sqlite3", database: "barbershop.db"}

class Client < ActiveRecord::Base 
end

class Barber < ActiveRecord::Base
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end
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

before do
	@barbers = Barber.all	
	#@barbers = Barber.order "created_at desc"
end

get '/' do
	erb :index
end

get '/Visit' do 
	erb :visit
end

get '/Contacts' do 
	erb :contacts
end

post '/Visit' do
	@username = params[:username]
	@phone = params[:phone]
	@date = params[:date]
	@barber = params[:barber]
	@color = params[:colorpicker]

	hh = {username: 'Введите имя',
	 	 phone:'Введите телефон',
	  	 date:'Введите дату и время'}
	hh.each do |key, value|
		if params[key] == ''
			@error = hh[key]
			return erb :visit
		end
	end

	Client.create :name => @username, :phone => @phone, :datestamp => @date, :barber => @barber, :color => @color

	
end
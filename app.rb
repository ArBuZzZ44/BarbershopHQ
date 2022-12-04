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
	validates :name, presence: true, length: {minimum: 3}
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

before do
	@barbers = Barber.all	
	#@barbers = Barber.order "created_at desc"
end

get '/' do
	erb :index
end

get '/Visit' do 
	@c = Client.new
	erb :visit
end

post '/Visit' do
	@c = Client.new params[:client]
	if @c.save
		erb "<h2>Спасибо, вы записались!</h2>"
	else
		@error = @c.errors.full_messages.first
		erb :visit
	end	
end

get '/Contacts' do 
	erb :contacts
end

post '/Contacts' do 
	@mail = params[:mail]
	@report = params[:report]

	hh = {mail: 'Введите почтовый адрес',
		report: 'Введите сообщение'}

	hh.each do |key, value|
		if params[key] == ''
			@error = hh[key]
			return erb :contacts
		end
	end

	@title = 'Мы приняли ваше сообщение'
	@message = 'Постараемся с вами связаться по вашему вопросу как можно скорее'

	Contact.create :mail => @mail, :report => @report

	erb :message
end

get '/About' do
	erb :about
end

get '/barber/:id' do 
	@barber = Barber.find(params[:id])
	erb :barber
end

get '/Bookings' do 
	@clients = Client.order('created_at DESC')
	erb :bookings
end

get '/client/:id' do 
	@client = Client.find(params[:id])
	erb :client
end
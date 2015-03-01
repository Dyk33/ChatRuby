# mon_application.rb
require 'sinatra'
require 'mongoid'
Mongoid.load!('mongoid.yml', :dev)
#enable: sessions

#Connection à la base de donnée 
uri = "mongodb://Coralie:ingesup33@ds063869.mongolab.com:63869/chatruby"
client = Mongo::MongoClient.from_uri(uri)


#Document USER
class User	
	include Mongoid::Document
	field :ID,type: Integer 
	field :pseudo,type: String
	collection :'messages'
end

#Document Message
class Message
	include Mongoid::Document
	field :message,   type: String
	belongs_to :user
end


@pseudo
@messages

get '/' do
  erb :index
end


get '/chat' do	

	#pseudo = params[:pseudo]
	#@pseudo = pseudo
	#if @pseudo != ""	
	#@messages = "Thomas : Coucou!"

	if(!session[:id].nil? && !session[:user].nil?)
	    @userId = session[:id]
	    @userSession = session[:user]
	#Affichage des messages dans le textArea
	    @messages = Message.all
		erb	:chatView
	else
		erb :index
  	end  
end

post '/chat' do
	#Enregistre message in bdd
    @mess = Message.create(params[:message])
    redirect to("/chat")

	#Mise à jour de la variable @messages

	# Reaffiche chat
	pseudo = params[:pseudo]
	@pseudo = pseudo
	redirect("/chat")
end

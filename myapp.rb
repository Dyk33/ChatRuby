# mon_application.rb
require 'sinatra'
require 'mongoid'
require 'yaml'
require 'json'

YAML::ENGINE.yamler = 'syck'
Mongoid.load!('mongoid.yml')
#enable: sessions
use Rack::Session::Pool, :expire_after => 2592000

#Connection à la base de donnée 
#uri = "mongodb://Coralie:ingesup33@ds063869.mongolab.com:63869/chatruby"
#client = Mongo::MongoClient.from_uri(uri)


#Document USER
class User	
	include Mongoid::Document
	field :pseudo, type: String
	collection :messages
end

#Document Message
class Message
	include Mongoid::Document
	field :message, type: String
	belongs_to :user
end


@pseudo
@messages

get '/' do
  erb :index
end


get '/chat' do	
	if !params[:pseudo].nil?
		session[:pseudo] = params[:pseudo]
	    @pseudo = session[:pseudo]

		#Affichage des messages dans le textArea (AFFICHER LES MESSAGES PAR UTILISATEUR)
	    @messages = Message.all
		erb	:chatView
	else
		erb :index
  	end  
end

post '/chat' do
	#Recup User in Bdd
	user = User.where(pseudo: session[:pseudo])
		if user.nil?
			user = User.new(pseudo :session[:pseudo])
		end

	#Enregistre message in bdd
    mess = Message.new(message: params[:message], user: user)

    user.messages.push(mess)
    user.reload.messages

    mess.save
    user.save

	#Mise à jour de la variable @messages (AFFICHER LES MESSAGES PAR UTILISATEUR)
	@messages = Message.all

	# Reaffiche chat
	@pseudo = session[:pseudo]

	redirect("/chat")
end


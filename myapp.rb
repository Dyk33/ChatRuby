# mon_application.rb
require 'sinatra'
require 'mongoid'
require 'yaml'
require 'json'

YAML::ENGINE.yamler = 'syck'
Mongoid.load!('mongoid.yml', :production)
#enable: sessions
use Rack::Session::Pool, :expire_after => 2592000

#Connection à la base de donnée 
#uri = "mongodb://Coralie:ingesup33@ds063869.mongolab.com:63869/chatruby"
#client = Mongo::MongoClient.from_uri(uri)


#Document USER
class User	
	include Mongoid::Document
	field :pseudo, type: String
	has_many :messages
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
	    Message.each do |m|
	    	if @message.nil?
		  		@message = m.message
		  	else
		  		@message= @message + "\n"+ m.message
		  	end
		end

		puts Message.count

		erb	:chatView
	else
		redirect to("/")
  	end  
end

post '/chat' do

	puts session[:pseudo]

	#Recup User in Bdd
	exist = User.where(pseudo: session[:pseudo]).exists?
	if exist
		user = User.where(pseudo: session[:pseudo]).first
	else
		user = User.create(pseudo: session[:pseudo])
	end

	#Enregistre message in bdd
    mess = Message.create(message: params[:message], user: session[:pseudo])

    user.messages.push(mess)
    user.reload.messages

    mess.save
    user.save

	#Mise à jour de la variable @messages (AFFICHER LES MESSAGES PAR UTILISATEUR)
	#Message.all.each do |m|
		#@message = @message + m.message
	#end
	redirect to("/chat")
end


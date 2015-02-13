# mon_application.rb
require 'sinatra'
require 'mongoid'
Mongoid.load!('mongoid.yml', :dev)
#enable: sessions

class User
  	
	include Mongoid::Document
	field :ID,type: Integer 
	field :pseudo,type: String
	collection :'messages'
  

end

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

	pseudo = params[:pseudo]
	@pseudo = pseudo
	if @pseudo != ""
		#Connection à la base de donnée et affichage des messages dans le textArea
		@messages = "Thomas : Coucou!"
		erb	:chatView
	else
		erb :index
  	end  
end

post '/chat' do
	#Enregistre message in bdd
	

	#Mise à jour de la variable @messages

	# Reaffiche chat
	pseudo = params[:pseudo]
	@pseudo = pseudo
	redirect("/chat")
end

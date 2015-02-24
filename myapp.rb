# mon_application.rb
require 'sinatra'
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

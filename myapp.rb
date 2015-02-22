# mon_application.rb
require 'sinatra'
@pseudo = ""

get '/' do
  erb :index
end

post '/' do
	pseudo = params[:pseudo]
	@pseudo = pseudo
	if @pseudo != ""
		erb	:chatView
	else
		erb :index
  	end  	
end

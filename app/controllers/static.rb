# app/controllers/users.rb
require 'byebug'

enable :sessions

get '/' do
	puts "[LOG]Inside /"
	@all_url = Url.all
	erb :"static/index"
end

get '/url' do
	puts "[LOG] get /url"
	redirect '/'
end

post '/url' do
	puts "[LOG] Pressed Submit"
	puts "[LOG] Param: #{params.inspect}"

	@url = Url.create(long_url: params[:long_url], short_url: Url.shorten)

	redirect '/'
end

get '/signup' do
	erb :'users/new'
end

post '/signup' do
	# Do something processing with user input
	redirect to '/user/dashboard'
end

get '/user/dashboard' do
	erb :dashboard
end

get '/error' do
	erb :"static/error"
end

get '/:short_url' do
	result = Url.where(short_url: params['short_url']).first
	redirect result.blank? ? '/error' : result.long_url
end
# app/controllers/users.rb
require 'byebug'
require 'sinatra'
require 'sinatra/flash'

enable :sessions

get '/' do
	# @all_url = Url.all
	@all_url = Url.paginate(page: params[:page], per_page: 50)
	@error = "Invalid URL" if params[:error]
	erb :"static/index"
end

get '/url' do
	puts "[LOG] get /url"
	redirect '/'
end

post '/url' do
	# params[:url][:short_url] = Url.shorten
	@url = Url.new(params[:url])
	if @url.save
		@url.to_json(except: :id)
		# Only be seen until the NEXT access of /url
		# flash[:notice] = "Your URL has been cut into #{@url.short_url}"
	else
		status 400
		@url.errors.full_messages.join(', ')
		# Go to '/' with params[:error] = "0"
		# redirect "/?error=#{@url.long_url}"
	end

	# redirect '/'
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
	redirect '/error' if result.blank?
	result.click_count += 1
	result.save
	redirect result.long_url
end


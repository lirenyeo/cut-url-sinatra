get '/' do
  @root_url = request.base_url
  # @all_url = Url.all
  @all_url = Url.paginate(page: params[:page], per_page: 20).order("created_at DESC")
  @error = "Invalid URL" if params[:error]
  erb :"static/index"
end

get '/url' do
  puts "[LOG] get /url"
  redirect '/'
end

post '/url' do
  @root_url = request.base_url
  @url = Url.new(params[:url])
  if @url.save
    @all_url = Url.paginate(page: params[:page], per_page: 20).order("created_at DESC")
    erb :"static/table", layout: false
  else
    status 404
    @url.errors.full_messages.join('. ')
  end

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

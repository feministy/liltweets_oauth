get '/' do
  erb :index
end

get '/sign_in' do
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  session.delete(:request_token)
  user = User.find_or_create_by_oauth_token(username: @access_token.params[:screen_name],
                     oauth_token: @access_token.params[:oauth_token],
                     oauth_secret: @access_token.params[:oauth_token_secret])
  session[:user_id] = user.id
  redirect to "/tweets/new"
end

get "/tweets/new" do
  erb :tweet
end

get '/status/:job_id' do
  finished = job_is_complete(params[:job_id])
  content_type :json
  {:finished => finished}.to_json
end

post '/new/tweet' do
  if params[:interval]
    job_id = current_user.tweet_in(params[:interval].to_i, params[:status])
  else 
    job_id = current_user.tweet(params[:status])
  end 

  unless request.xhr?
    erb :tweet
  end

  content_type :json
  {:job => job_id}.to_json
end

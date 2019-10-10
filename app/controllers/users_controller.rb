class UsersController < ApplicationController
  set :views, 'app/views'

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    # binding.pry
    if params[:username].empty? || params[:email].empty? || params[:password].empty? || params[:password_confirmation].empty? || params[:password] != params[:password_confirmation]
      redirect '/users/new'
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect '/tweets'
    end
  end

  get '/users/login' do
    erb :'users/login'
  end

  post '/users/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/users/new'
    end
  end

  get '/users/logout' do
    if logged_in?
      session.destroy
      redirect '/users/login'
    else
      redirect '/'
    end
  end
end

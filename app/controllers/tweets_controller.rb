class TweetsController < ApplicationController
  set :views, 'app/views/'

  get '/tweets' do
    @tweets = Tweet.all.order(created_at: :desc)
    erb :'tweets/index'
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/users/login'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit'
  end

  post '/tweets' do
    # binding.pry
    if logged_in?
      if params[:content].empty?
        redirect '/tweets/new'
      else
        new_tweet = Tweet.create(params)
        new_tweet.user = current_user
        new_tweet.save
        redirect '/tweets'
      end
    else
      redirect '/users/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content].empty?
      redirect '/tweets/:id/edit'
    else
      @tweet = Tweet.find(params[:id])
      @tweet.update(content: params[:content])
      redirect '/tweets'
    end
  end

  get '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.delete
    redirect '/tweets'
  end
end

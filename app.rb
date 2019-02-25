# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'active_record'
require 'rack/csrf'
require './models/comment'
require './models/user'

class App < Sinatra::Base
  use Rack::Session::Cookie, secret: Digest::SHA256.hexdigest(rand.to_s),
                             expires_after: 3600

  use Rack::Csrf, raise: true

  helpers do
    def csrf_tag
      Rack::Csrf.csrf_tag(env)
    end

    def csrf_token
      Rack::Csrf.csrf_token(env)
    end

    def h(str)
      Rack::Utils.escape_html(str)
    end
  end

  ActiveRecord::Base.establish_connection(ENV['DB_URL'])

  get '/' do
    redirect to("/users/#{session[:id]}") if session[:id]

    @title = 'Log in'
    erb :index
  end

  post '/login' do
    user = User.find_by(name: params[:name])
    redirect to('/') if user.nil?
    redirect to('/') if user.password != params[:password]

    session[:id] = user.id
    redirect to("/users/#{session[:id]}")
  end

  get '/comments' do
    @title = 'My BBS'
    @comments = Comment.all
    erb :comments
  end

  post '/create' do
    Comment.create(body: params[:body])
    redirect to('/comments')
  end

  post '/destroy' do
    Comment.find(params[:id]).destroy
  end

  get '/signup' do
    @title = 'Sign up'
    erb :signup
  end

  post '/signup' do
    User.create(name: params[:name], password: params[:password])
    redirect to('/')
  end
end

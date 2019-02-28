# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'active_record'
require 'rack/csrf'
require './models/activity'
require './models/category'
require './models/menu'
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
    redirect to('/activities') if session[:id]

    @title = 'Log in'
    erb :index
  end

  post '/login' do
    user = User.find_by(name: params[:name])
    redirect to('/') if user.nil?
    redirect to('/') if user.password != params[:password]

    session[:id] = user.id
    redirect to('/activities')
  end

  get '/activities' do
    @id = session[:id]
    redirect to('/') unless @id
    @user = User.includes(activities: [:menu]).find_by(id: @id)
    @categories = Category.includes(:menus).all

    @title = 'Activities'
    erb :activities
  end

  post '/activities/create' do
    @user_id = session[:id]
    @menu = Menu.find_by(name: params[:name])
    redirect to('/activities') unless @menu

    Activity.create(user_id: @user_id,
                    menu_id: @menu.id,
                    reps: params[:reps],
                    sets: params[:sets],
                    acted_at: params[:acted_at])
    redirect to('/activities')
  end

  post '/activities/:id/destroy' do
    Activity.find(params[:id]).destroy
    redirect to('/activities')
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

# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'

get '/' do
  headers \
    'Access-Control-Allow-Origin' => '*'

  body 'hello sinatra-workout-recording'
end

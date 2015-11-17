require 'sinatra'
require 'pry'
require 'csv'

get '/articles' do
  @arr_of_arrs = CSV.read("articles.csv")
  erb :index
end


get '/articles/new' do
  erb :form
end


post '/articles/new' do
 p article = params['article']
 p url = params['url']
 p description = params['description']
  CSV.open("articles.csv", "a") do |csv|
    csv << [article, url, description]
  end

  redirect '/articles'
end

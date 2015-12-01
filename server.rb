require 'sinatra'
require 'csv'

get '/articles' do
  @articles = CSV.read('news_aggregator.csv', headers: true, header_converters: :symbol)
  erb :index
end

get '/articles/new' do
	  erb :show
	end
	
post '/articles/new' do
  @invalid_entry = nil
  @title = params[:title]
  @url = params[:url]
  @description = params[:description]
  @data_combined = [@title, @url, @description]

	@articles = CSV.read("news_aggregator.csv")
  @articles.each do |arrays|
   	if @url == arrays[1]
    	 @invalid_entry = "Invalid Entry: Article URL already exists"
   	end
  end

  if @invalid_entry.nil?
  CSV.open('news_aggregator.csv', 'a') do |csv|
    csv << @data_combined
  end

  redirect '/articles'
	else
  	CSV.open("temp.csv", "a") do |csv|
    	csv << @data_combined
  	end

  	erb :show
	end
end

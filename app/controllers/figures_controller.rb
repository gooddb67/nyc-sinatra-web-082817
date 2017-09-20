  require 'pry'
class FiguresController < ApplicationController

  get '/figures/new' do

    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure]) #creates a new figure
    if !params[:title][:name].empty? #if the title field is not emptuy
        @figure.titles  << Title.create(params[:title]) #create a new title, add to @figure.titles
      end
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end
    @figure.save
    # binding.pry
    redirect to '/figures' #erb :index requires @figures, not present in this route. so we redirceted to figures., which has @figures.
  end

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    if !params[:title][:name].empty? #if the title field is not emptuy
        @figure.titles  << Title.create(params[:title]) #create a new title, add to @figure.titles
      end
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end
      @figure.save
      redirect to "/figures/#{@figure.id}"
  end


end

require 'gossip'
require 'comment'
class ApplicationController < Sinatra::Base

  get '/' do #config home page
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do #config page to make new gossip
    erb :new_gossip
  end

  post '/gossips/new/' do # gets author en content from forms of new page
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id/' do # dynamic url for all gossip id and comment id for dynamic comment with gossip
    erb :show, locals: {gossip: Gossip.find(params['id']), comments: Comment.all_with_id(params[:id].to_i)}
  end

  post '/gossips/:id/' do # gets comment from forms of gossip page
		Comment.new(params['id'].to_i, params["gossip_comment"]).save
    redirect '/'
  end

  get '/gossips/:id/edit/' do # config edit page
    erb :edit, locals: {id: params['id'].to_i, gossip: Gossip.find(params['id'].to_i)}
  end

  post '/gossips/:id/edit/' do # form from edit page
    Gossip.update(params['id'].to_i, params["gossip_author"], params["gossip_content"])
    redirect '/'
  end

end
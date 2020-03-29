class RelationshipsController < ApplicationController
  protect_from_forgery :except => [:create, :destroy]

  def index
    @relationships = Relationship.all
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def create
    Relationship.new
    Relationship.create(user_id: params[:user_id], follow_id: params[:follow_id])
  end

  def destroy
    relationship = Relationship.find(params[:id])
    relationship.delete
  end

end

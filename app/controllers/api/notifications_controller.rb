class Api::NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(visited_id: params[:id])
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end
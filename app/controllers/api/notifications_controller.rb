class Api::NotificationsController < ApplicationController
  protect_from_forgery except: [:create]

  def index
    @notifications = Notification.where(visited_id: params[:id])
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def update
    @notifications = Notification.where(visited_id: params[:id])
    @notifications.update(checked: true)
  end
end
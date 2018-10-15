class AuthenticatedController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user
  after_action :track_action

  def set_current_user
    @current_user ||= current_user
    @unit_role = @unit.role_for(user: @current_user) if @unit.present?
    @current_user_is_admin = @unit_role == 'admin' if @unit_role.present?
  end

  def track_action
    Tracker.track(user: @current_user, event_name: "#{ controller_path }.#{ action_name }", properties: @tracking_properties )
  end

  def authenticate_user!
    if valid_auth_token_present?
      @current_user = User.first
    else
      super
    end
  end

  def valid_auth_token_present?
    request.headers['Authorization'].present? && Rails.env == 'development'
  end
end

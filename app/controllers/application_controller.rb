class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  before_action :set_raven_context
  layout :select_layout

  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    klass.new(object, view_context)
  end

  def select_layout
    user_signed_in? ? 'application' : 'unauthenticated'
  end

  private

  def set_raven_context
    return unless ENV['RAILS_ENV'] == 'production'
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end

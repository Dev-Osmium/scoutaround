class StripeController < AuthenticatedController
  include ApplicationHelper
  layout 'narrow'

  #
  # this is the return route from Stripe Connect.
  # See https://stripe.com/docs/connect/quickstart for more
  #
  def payment_setup
    error = params[:error]
    if error.present?
      error_description = params[:error_description]
      flash[:error] = error_description
      redirect_to edit_unit_unit_setting_path(@unit, :payments)
      return
    end

    auth_code = params[:code]
    # state = params[:state]
    # crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base)
    # crypt = generate_crypt
    # unit_id = crypt.decrypt_and_verify(state)
    unit_id = session[:unit_id]
    conn = Faraday.new(url: 'https://connect.stripe.com')
    data = {
      client_secret: ENV['STRIPE_SECRET_KEY'],
      code: auth_code,
      grant_type: 'authorization_code'
    }

    response = conn.post '/oauth/token', data
    json = JSON.parse(response.body)
    @unit = @current_user.units.find(unit_id)
    @unit.stripe_user_id = json['stripe_user_id']
    @unit.save!

    flash[:notice] = t('units.success.payment_setup')
    session[:unit_id] = nil
    redirect_to edit_unit_unit_setting_path(@unit, :payments)
  end

  def show
    @unit = Unit.find(params[:unit_id])
    session[:unit_id] = @unit.id # kludge alert: the Stripe callback URL can't be dynamic, so we need to cache the unit we're setting up
  end
end

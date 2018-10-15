require 'rails_helper'
include ApplicationHelper

RSpec.feature "Advancement features", :type => :feature do
  before do
    sign_in # see spec/support/feature_spec_helper
  end

  describe 'setup' do
    before do
      visit unit_payments_path(@unit)
    end

    describe 'pre-setup' do
      it 'visits the payments setup page' do
        expect(page).to have_current_path(unit_payments_path(@unit))
      end

      it 'unit does not yet accept payments' do
        expect(@unit.accepts_payments?).to be_falsey
      end
    end

    describe 'post-setup' do
      before do
        @unit.stripe_user_id = 'abc123'
      end
    end
  end
end

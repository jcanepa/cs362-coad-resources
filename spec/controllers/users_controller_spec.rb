require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  # let's cover some empty classes with instanciation tests!
  it 'exists' do
    UsersController.new
  end

  context 'users confirmations controller' do
    it 'exists' do
      Users::ConfirmationsController.new
    end
  end

  context 'users omni auth callbacks controller' do
    it 'exists' do
      Users::OmniauthCallbacksController.new
    end
  end

  context 'users passwords controller' do
    it 'exists' do
      Users::PasswordsController.new
    end
  end

  context 'users registrations controller' do
    it 'exists' do
      Users::RegistrationsController.new
    end
  end

  context 'users sessions controller' do
    it 'exists' do
      Users::SessionsController.new
    end
  end

  context 'users unlocks controller' do
    it 'exists' do
      Users::UnlocksController.new
    end
  end

end
require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  let (:user) { create(:user, email: "email@email.com", password: "password", role: 1) }

  describe 'GET ticket index' do
    it { expect(get(:new)).to be_successful }
  end
end

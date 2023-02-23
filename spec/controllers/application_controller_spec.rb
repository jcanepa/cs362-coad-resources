require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  let(:app_controller) { ApplicationController.new }

  it 'exists' do
    app_controller
  end

  it "responds to after_sign_in_path_for" do
    expect(app_controller).to respond_to(:after_sign_in_path_for)
  end


  describe '#after_sign_in_path_for user returns dashboard path' do
    let(:user) { create(:user) }

    controller(ApplicationController) do
      def after_sign_up_path_for(resource)
          super resource
      end
    end

    it {
      expect(
        controller.after_sign_in_path_for(user)).to eq dashboard_path
    }
  end
end
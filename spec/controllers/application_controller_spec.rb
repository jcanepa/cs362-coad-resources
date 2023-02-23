require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:ac) { ApplicationController.new }
  it 'exists' do
    ac
  end

  it "responds to after_sign_in_path_for" do
    expect(ac).to respond_to(:after_sign_in_path_for)
  end

  it "after_sign_in_path_for returns dashboard path" do
    expect(ac.after_sign_in_path_for).to eq dashboard_path
  end
end
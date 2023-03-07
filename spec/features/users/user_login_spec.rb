require 'rails_helper'

RSpec.describe 'Logging in', type: :feature do
    describe "Normal user" do
        it "can log in" do
            user = create(:user, 
                email: "email@email.com",
                password: "password")

            #visit dashboard_path

            visit login_path

            fill_in('Email address', with: user.email)
            fill_in('Password', with: user.password)

            find_by_id('commit').click
            expect(current_path).to eq("/dashboard")
        end
    end
end

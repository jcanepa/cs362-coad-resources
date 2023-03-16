require 'rails_helper'

RSpec.describe 'User registration', type: :feature do
    
    it "a new user can sign up" do
        visit root_path
        click_on("Sign up")

        fill_in("Email address", with: "email@domain.com")
        fill_in("Password", with: "password")
        fill_in("Password confirmation", with: "password")
        click_on("commit")

        expect(page).to have_content('confirmation link')
    end
end

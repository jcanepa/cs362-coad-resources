require 'rails_helper'

RSpec.describe User, type: :model do

    let (:user) { User.new }

    # Test instantiation

    it "exists" do
        user
    end

    # Test attributes

    it "has a name" do
        expect(user).to respond_to(:name)
    end

    it "has an email" do
        expect(user).to respond_to(:email)
    end

    it "has a password" do
        expect(user).to respond_to(:password)
    end

    # Test associations

    context 'associations' do
        it { should belong_to(:organization).class_name('Organization').optional }
    end

end

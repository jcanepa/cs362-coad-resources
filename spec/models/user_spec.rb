require 'rails_helper'

RSpec.describe User, type: :model do

    let (:user) { User.new }

    # Test instantiation

    it "exists" do
        user
    end

    # Test attributes

    it "has an email" do
        expect(user).to respond_to(:email)
    end

    it "has a password" do
        expect(user).to respond_to(:password)
    end

    # Test functions

    it "can set default role" do
        expect(user).to respond_to(:set_default_role)
    end

    it "can print email to string" do
        expect(user).to respond_to(:to_s)
    end

    # Test associations

    context 'associations' do
        it { should belong_to(:organization).class_name('Organization').optional }
    end

    # Test Validators

    it "validates email presence" do
        expect(user).to validate_presence_of(:email)
    end

    it "validates email length" do
        expect(user).to validate_length_of(:email)
    end

    it "validates email uniqueness" do
        expect(user).to validate_uniqueness_of(:email)
    end

    it "validates password presence" do
        expect(user).to validate_presence_of(:password)
    end

    it "validates password length" do
        expect(user).to validate_length_of(:password)
    end

end

require 'rails_helper'

RSpec.describe User, type: :model do

    let (:user) { 
        User.new(

            email: "email@email.com",
            password: "password",
            role: 1

    ) }

    # Test instantiation

    it "exists" do
        user
    end

    # Test attributes

    it "has an email" do
        expect(user)
        .to respond_to(:email)
    end

    it "has a password" do
        expect(user)
        .to respond_to(:password)
    end

    it "has a role" do
        expect(user)
        .to respond_to(:role)
    end

    # Test functions

    it "can set default role" do
        expect(user)
        .to respond_to(:set_default_role)
    end

    it "can print email to string" do
        expect(user)
        .to respond_to(:to_s)
    end

    # Test associations

    context 'associations' do
        it { should belong_to(:organization).class_name('Organization').optional }
    end

    # Test Validators

    it "validates email presence" do
        expect(user)
        .to validate_presence_of(:email)
    end

    
    it "verifies the minimum length of name" do
        expect(user)
        .to validate_length_of(:email)
        .is_at_least(1)
        .on(:create)
    end

    it "verifies the maximum length of name" do
        expect(user)
        .to validate_length_of(:email)
        .is_at_most(255)
        .on(:create)
    end

    it "validates email uniqueness" do
        expect(user)
        .to validate_uniqueness_of(:email)
        .ignoring_case_sensitivity
    end

    it "validates email structure (regex)" do
        
        #expect()
    end

    it "validates password presence" do
        expect(user)
        .to validate_presence_of(:password)
    end

    it "validates the minimum length of name" do
        expect(user)
        .to validate_length_of(:password)
        .is_at_least(7)
        .on(:create)
    end

    it "validates the maximum length of name" do
        expect(user)
        .to validate_length_of(:password)
        .is_at_most(255)
        .on(:create)
    end

end

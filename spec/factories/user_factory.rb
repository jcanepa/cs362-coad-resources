FactoryBot.define do
    factory :user do
        email # this will use the sequence
        password { "secret" }

        before(:create) { |user| user.skip_confirmation! }

        # user with an approved org
        trait :organization_approved do
            role { :organization }
            organization_id { create(:organization, :approved).id }
        end

        # user with an unapproved org
        trait :organization_unapproved do
            role { :organization }
            organization_id { create(:organization).id }
        end
    end
end

FactoryBot.define do
    # used when attribute doesnt have default in factory
    sequence :email do |n|
      "fake#{n}@factory.com"
    end

    sequence :name do |n|
      "Fake-#{n}"
    end
  end
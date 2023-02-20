FactoryBot.define do
    factory :user do
        email # defaults to factories/sequence
        password { "password" }

        before(:create) { |user| user.skip_confirmation! }

        # admin user
        trait :admin do
          role {:admin}
        end

        # user with an approved org
        trait :organization_approved_user do
            role { :organization }
            organization_id { create(:organization, :approved).id }
        end

        # user with an unapproved org
        trait :organization_unapproved_user do
            role { :organization }
            organization_id { create(:organization).id }
        end

<<<<<<< HEAD
        trait :no_organization_user do

        end

        trait :admin do
          role {:admin}
        end

=======
>>>>>>> 6bd5c6a975639329faa74f42cfa7e250e1418495
    end
end
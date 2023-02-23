FactoryBot.define do
  factory :organization, class: "Organization" do
    name
    email
    phone {"555-555-5555"}
    primary_name {"primary_name"}
    secondary_name {"secondary_name"}
    secondary_phone {"666-666-6666"}

    trait 'approved' do; end
  end
end
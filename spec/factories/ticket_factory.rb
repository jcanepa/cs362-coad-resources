FactoryBot.define do
  factory :ticket do
    name
    phone {5105555555}
    description {"Foo bar baz."}

    # an uncaptured ticket is not associated with an organization.
    trait :uncaptured do
      organization_id { nil }
    end

  end
end

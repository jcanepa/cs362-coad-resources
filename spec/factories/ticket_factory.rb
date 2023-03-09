FactoryBot.define do
  factory :ticket do
    name
    phone {5105555555}
    description {"Foo bar baz."}
    region_id {create(:region).id}
    resource_category_id {create(:resource_category).id}

    # an uncaptured ticket is not associated with an organization.
    trait :uncaptured do
      organization_id { nil }
    end

  end
end

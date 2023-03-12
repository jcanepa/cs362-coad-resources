FactoryBot.define do
  factory :ticket do
    name
    phone {5105555555}
    description {"Foo bar baz."}
    region_id {create(:region).id}
    resource_category_id {create(:resource_category).id}

    # uncaptured tickets are not associated with an organization
    trait :uncaptured do
      organization_id { nil }
    end

    # captured tickets belong to an organization
    trait :captured_by_organization do
      organization_id { create(:organization).id }
    end

    trait :captured_by_approved_organization do
      organization_id { create(:organization, :approved).id }
    end

  end
end

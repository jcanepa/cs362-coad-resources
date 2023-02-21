FactoryBot.define do
  factory :ticket do
    name
    phone {5105555555}
    description {"Foo bar baz."}
  end
end

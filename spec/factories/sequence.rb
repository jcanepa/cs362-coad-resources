FactoryBot.define do
    # used when attribute doesnt have default in factory
    sequence :email do |n|
      "fake#{n}@factory.com"
    end

    sequence :name do |n|
      "Fake-#{n}"
    end
  end
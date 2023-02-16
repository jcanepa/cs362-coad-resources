FactoryBot.define do
    # these attributes serve as the default for ALL factories with a matching name
    # but is only used when attribute doesnt have default set in the model's factory
    sequence :email do |n|
      "fake#{n}@factory.com"
    end

    sequence :name do |n|
      "Fake-#{n}"
    end
  end
require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  let (:resource_category) { ResourceCategory.new }

  # Test instanciation
  it "exists" do
    resource_category
  end

end

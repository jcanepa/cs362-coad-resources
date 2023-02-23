require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "testing full_title in application helper" do
    
    context "testing without a title" do
      it {expect(helper.full_title()).to eq("Disaster Resource Network")}
    end

    context "testing with title" do
      it {expect(helper.full_title("Title")).to eq("Title | Disaster Resource Network")}
    end
  end
end

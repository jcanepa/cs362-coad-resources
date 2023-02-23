require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TIcketsHelper. For example:
#
# describe TIcketsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TicketsHelper, type: :helper do
    describe "can format phone number" do
        it {
            expect(helper.format_phone_number('+1 541-555-5555')).to eq '+15415555555'
        }

        it {
            expect(helper.format_phone_number('+1 5415555555')).to eq '+15415555555'
        }

        it {
            expect(helper.format_phone_number('5415555555')).to eq '+15415555555'
        }
    end
end

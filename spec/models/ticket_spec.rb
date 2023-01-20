require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let (:ticket) { Ticket.new }

  it "exists" do
    ticket
  end
end

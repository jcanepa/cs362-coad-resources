module TicketService
  class << self
    def release_ticket(id, user)
      catch :error do
        ticket = Ticket.find(id)
        throw :error, 'User does not have permission to release ticket' unless user_can_release?(ticket, user)
        ticket.organization_id = nil
        throw :error, 'Failed to release ticket' unless ticket.save
        :ok
      end
    end

    def capture_ticket(id, user)
      catch :error do
        ticket = Ticket.find(id)
        throw :error, 'User does not have permission to capture ticket' unless user_can_capture?(ticket, user)
        ticket.organization_id = user.organization_id
        throw :error, 'Failed to capture ticket' unless ticket.save
        :ok
      end
    end

    def close_ticket(id, user)
      catch :error do
        ticket = Ticket.find(id)
        throw :error, 'User does not have permission to close ticket' unless user_can_close?(ticket, user)
        ticket.closed = true
        ticket.closed_at = Date.today.iso8601
        throw :error, 'Failed to close ticket' unless ticket.save
        :ok
      end
    end

    private

    def user_can_release?(ticket, user)
      ticket.organization_id.present? && user.organization_id == ticket.organization_id || user.admin?
    end

    def user_can_capture?(ticket, user)
      # ticket is not already assigned to an org
      # AND the user is associated with an approved org
      ticket.organization_id.nil? && user&.organization&.approved?
    end

    def user_can_close?(ticket, user)
      ticket.organization_id == user&.organization&.id || user.admin?
    end
  end
end
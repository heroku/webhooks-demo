module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include AuthenticatingController

    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      authenticate_user || reject_unauthorized_connection
    end
  end
end

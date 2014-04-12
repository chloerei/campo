class User
  module Confirmable
    extend ActiveSupport::Concern

    def confirm
      update_attribute :confirmed, true
    end

    def confirmation_token
      self.class.verifier_for('confirmation').generate([id, Time.now])
    end

    module ClassMethods
      def find_by_confirmation_token(token)
        user_id, timestamp = verifier_for('confirmation').verify(token)
        User.find_by(id: user_id) if timestamp > 1.hour.ago
      rescue ActiveSupport::MessageVerifier::InvalidSignature
        nil
      end
    end
  end
end

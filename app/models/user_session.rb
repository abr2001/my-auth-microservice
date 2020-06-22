class UserSession < Sequel::Model
  plugin :uuid

  many_to_one :user

  def validate
    super

    contract = UserSessionAttributesContract.new
    result = contract.call(uuid: uuid, user_id: user_id)

    if result.errors.any?
      result.errors.to_h.each do |attribute, error_messages|
        errors[attribute] = error_messages
      end
    end
  end
end

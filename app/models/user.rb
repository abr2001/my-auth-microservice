class User < Sequel::Model
  plugin :secure_password
  plugin :association_dependencies

  one_to_many :sessions, class_name: 'UserSession'

  add_association_dependencies sessions: :destroy

  def validate
    super

    contract = UserAttributesContract.new
    result = contract.call(name: name, email: email)

    if result.errors.any?
      result.errors.to_h.each do |attribute, error_messages|
        errors[attribute] = error_messages
      end
    end
  end
end

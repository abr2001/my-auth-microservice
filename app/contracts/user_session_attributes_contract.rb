class UserSessionAttributesContract < Dry::Validation::Contract
  params do
    required(:uuid).filled(:string)
    required(:user_id).filled(:integer)
  end
end

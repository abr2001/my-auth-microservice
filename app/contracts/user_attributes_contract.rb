class UserAttributesContract < Dry::Validation::Contract
  NAME_FORMAT = %r{\A\w+\z}

  params do
    required(:name).filled(:string)
    required(:email).filled(:string)
  end

  rule(:name) do
    unless NAME_FORMAT.match?(value)
      key.failure I18n.t(:format, scope: 'model.errors.user.name')
    end
  end
end

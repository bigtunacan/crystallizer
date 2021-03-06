class User < Crecto::Model

  schema "users" do
    field :email, String
    field :login, String
    field :password, String
    field :subscribed, Bool
  end

  validate_required [:email, :login, :password]
  #validate_length :password, min: 8
  #https://github.com/Crecto/crecto/blob/master/spec/spec_helper.cr#L135
  validate "Password must be at least 8 characters", ->(user : User) do
    # TODO: check password requirements here.
    return true
  end

end

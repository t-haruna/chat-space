module ControllerMacros
  def login(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end
end
#deviseをテストする際に必要。
PASSWORD_FILE = File.join(Rails.root, 'db/password.hash')

Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = Tribunals::Admin::AuthenticationsController.action(:new)
end

class Warden::SessionSerializer
  def serialize(dummy)
    dummy.to_s
  end

  def deserialize(dummy)
    true
  end
end

Warden::Strategies.add(:password) do
  def valid?
    params[:password]
  end

  def authenticate!
    return BCrypt::Password.new(File.read(PASSWORD_FILE)) == params[:password] ? success!(true) : fail!
  end
end

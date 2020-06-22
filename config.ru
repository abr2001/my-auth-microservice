require_relative 'config/environment'

map '/api' do
  run AuthRoutes
end

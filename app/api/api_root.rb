class ApiRoot < Grape::API
  PREFIX = '/api'.freeze
  format :json
  mount V0::Base
end

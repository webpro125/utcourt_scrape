class Request < ApplicationRecord
  has_many :request_histories
  belongs_to :user
end

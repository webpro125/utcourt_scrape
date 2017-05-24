class RequestHistory < ApplicationRecord
  belongs_to :request
  belongs_to :receive_user, foreign_key: :receive_id, class_name: 'User'
  belongs_to :user
end

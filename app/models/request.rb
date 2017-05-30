class Request < ApplicationRecord
  has_many :request_histories
  belongs_to :user

  def message
    'Attorney ' + self.user.full_name + ' needs your help at ' + self.time.strftime('%H:%M:%S').to_s + ', ' + self.date.to_s +
    ', ' + self.court_location.to_s + ' to cover a ' + self.hearing.to_s + '. '
  end
end

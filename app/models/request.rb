class Request < ApplicationRecord
  has_many :request_histories
  belongs_to :user

  def message
    'Attorney ' + self.user.name.upcase + ' needs your help at ' + self.time.strftime('%H:%M:%S').to_s + ', ' + self.date.to_s +
    ', ' + self.court.to_s + ' to cover a ' + self.hearing.to_s + '. '
  end
end

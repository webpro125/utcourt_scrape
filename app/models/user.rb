class User < ApplicationRecord
  include Nameable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  # validates :name, length: { in: 2..64 }, presence: true,
  #           format: { with: RegexConstants::Letters::AND_NUMBERS,
  #                     message: 'Special letters are not allowed to input' }
  # validates :last_name, length: { in: 2..32 }, presence: true,
  #           format: { with: RegexConstants::Words::AND_SPECIAL,
  #                     message: 'Special letters are not allowed to input' }
  validates :first_name, :last_name, presence: true
  validates_uniqueness_of :first_name, :last_name, :allow_blank => true

  before_save {
    self.first_name = first_name.downcase
    self.last_name = last_name.downcase
  }
  has_many :requests


  def active_for_authentication?
    super && self.approved
  end

=begin
  def inactive_message
    "Sorry, Your account is not activated. Please contact with Site Administrator"
  end
=end

end

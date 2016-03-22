class Cv < ActiveRecord::Base
  attr_accessible :markdown

  belongs_to :user

  validates :user_id, presence: true
end

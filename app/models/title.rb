class Title < ActiveRecord::Base
  validates :title, presence: true
end

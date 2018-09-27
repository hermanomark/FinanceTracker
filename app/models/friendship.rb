class Friendship < ApplicationRecord
  belongs_to :user
  # tricky part, say what class is this
  belongs_to :friend, :class_name => 'User'
end

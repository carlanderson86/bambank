class Transfer < ApplicationRecord

  # Optional because it can be a promotion
  belongs_to :from_user, class_name: 'User', optional: true
  # Not optional
  belongs_to :to_user, class_name: 'User'
  # If it's linked to a promotion
  belongs_to :promotion, optional: true
end

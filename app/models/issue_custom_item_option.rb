class IssueCustomItemOption < ApplicationRecord
  belongs_to :issue_custom_item, optional: true

  validates :issue_custom_item, :label, presence: true
  validates :value, :order_num, numericality: { only_integer: true }
end

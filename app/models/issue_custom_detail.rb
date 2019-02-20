class IssueCustomDetail < ApplicationRecord
  belongs_to :issue_custom

  validates :issue_custom, presence: true
  validates :value, numericality: { only_integer: true }

  def issue_custom_item_option
    IssueCustomItemOption.find_by(issue_custom_item_id: issue_custom.issue_custom_item_id, value: value)
  end
end

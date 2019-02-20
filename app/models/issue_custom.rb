class IssueCustom < ApplicationRecord
  belongs_to :issue
  belongs_to :issue_custom_item
  has_many :issue_custom_details

  validates :issue, :issue_custom_item, presence: true
  validates :issue_id, uniqueness: { scope: :issue_custom_item_id }
end

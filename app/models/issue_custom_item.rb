class IssueCustomItem < ApplicationRecord
  module ItemType
    TEXT = 1
    SINGLE_SELECT = 2
    MULTI_SELECT = 3
  end

  has_many :issue_custom_item_options, dependent: :destroy
  has_many :issue_customs, dependent: :destroy
  has_many :issue_custom_details, through: :issue_customs

  validates :name, presence: true
  validates :item_type, inclusion: { in: [ItemType::TEXT, ItemType::SINGLE_SELECT, ItemType::MULTI_SELECT] }
  validates :order_num, numericality: { only_integer: true }
end

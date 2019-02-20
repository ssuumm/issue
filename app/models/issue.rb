class Issue < ApplicationRecord
  has_many :issue_customs

  scope :eq_title, ->(title) { where(title: title) if title.present? }
  scope :eq_custom_text, lambda { |issue_custom_item_id, text|
    joins(:issue_customs).where(issue_customs: { issue_custom_item_id: issue_custom_item_id, text: text }) if text.present?
  }
  scope :include_custom_single_select_values, lambda { |issue_custom_item_id, values|
    where(id: IssueCustom.select(:issue_id).where(issue_custom_item_id: issue_custom_item_id, selected_value: values)) if values.present?
  }
  class << self
    def search(condition)
      relation = Issue.eq_title(condition[:title])
      condition[:issue_customs]&.each { |c| relation = condition_for_custom(relation, c) }
      relation.order(id: :asc)
    end

    private

    def condition_for_custom(relation, custom)
      issue_custom_item = IssueCustomItem.find_by(id: custom[:issue_custom_item_id])
      case issue_custom_item&.item_type
        when IssueCustomItem::ItemType::TEXT
          relation.eq_custom_text(custom[:issue_custom_item_id], custom[:text])
        when IssueCustomItem::ItemType::SINGLE_SELECT
          relation.include_custom_single_select_values(custom[:issue_custom_item_id], custom[:selected_values])
        when IssueCustomItem::ItemType::MULTI_SELECT
          # TODO, 複数選択カスタム項目の検索条件を反映
          relation
        else
          relation
      end
    end
  end
end

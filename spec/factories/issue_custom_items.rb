FactoryBot.define do
  factory :issue_custom_item_text, class: IssueCustomItem do
    item_type IssueCustomItem::ItemType::TEXT
    name 'テキストカスタム項目'
    order_num 0
  end
  factory :issue_custom_item_single_select, class: IssueCustomItem do
    item_type IssueCustomItem::ItemType::SINGLE_SELECT
    name '単一選択カスタム項目'
    order_num 0
  end
  factory :issue_custom_item_multi_select, class: IssueCustomItem do
    item_type IssueCustomItem::ItemType::MULTI_SELECT
    name '複数選択カスタム項目'
    order_num 0
  end
end

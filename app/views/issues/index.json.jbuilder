json.array!(@issues) do |issue|
  json.extract! issue, :id, :title, :content, :created_at, :updated_at
  json.set! :issue_customs, issue.issue_customs do |issue_custom|
    json.extract! issue_custom, :id, :issue_custom_item_id, :text, :selected_value
    json.item_type issue_custom.issue_custom_item.item_type
    json.name issue_custom.issue_custom_item.name
    json.set! :issue_custom_details, issue_custom.issue_custom_details do |issue_custom_detail|
      json.extract! issue_custom_detail, :id, :value
      json.label issue_custom_detail.issue_custom_item_option.label
    end
  end
end

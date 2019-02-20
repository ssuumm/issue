require 'rails_helper'

RSpec.describe 'GET /issues', type: :request do

  def create_issue(title:, content:, text: nil, single_select_value: nil, multi_select_values: [])
    issue = create(:issue, title: title, content: content)
    create(:issue_custom, issue: issue, issue_custom_item: text_item, text: text)
    create(:issue_custom, issue: issue, issue_custom_item: single_select_item, selected_value: single_select_value)
    multi_select_custom = create(:issue_custom, issue: issue, issue_custom_item: multi_select_item)
    multi_select_values.each { |v| create(:issue_custom_detail, issue_custom: multi_select_custom, value: v) }
    issue
  end

  let!(:text_item) { create(:issue_custom_item_text, order_num: 10) }

  let!(:single_select_item) { create(:issue_custom_item_single_select, order_num: 20) }
  let!(:single_select_item_option1) { create(:issue_custom_item_option, issue_custom_item_id: single_select_item.id, value: 1, label: '単一選択肢1', order_num: 20) }
  let!(:single_select_item_option2) { create(:issue_custom_item_option, issue_custom_item_id: single_select_item.id, value: 2, label: '単一選択肢2', order_num: 10) }

  let!(:multi_select_item) { create(:issue_custom_item_multi_select, order_num: 30) }
  let!(:multi_select_item_option1) { create(:issue_custom_item_option, issue_custom_item: multi_select_item, value: 1, label: '複数選択肢1', order_num: 10) }
  let!(:multi_select_item_option2) { create(:issue_custom_item_option, issue_custom_item: multi_select_item, value: 2, label: '複数選択肢2', order_num: 30) }
  let!(:multi_select_item_option3) { create(:issue_custom_item_option, issue_custom_item: multi_select_item, value: 3, label: '複数選択肢3', order_num: 20) }

  before do
    3.times do
      create_issue(title: 'タイトルA', content: '本文')
      create_issue(title: 'タイトルA', content: '本文', text: 'テキストA')
      create_issue(title: 'タイトルA', content: '本文', text: 'テキストA', single_select_value: 1)
      create_issue(title: 'タイトルA', content: '本文', text: 'テキストA', single_select_value: 1, multi_select_values: [1, 2])
    end
  end

  def issue_response
    {
      id: Integer,
      title: String,
      content: String,
      created_at: String,
      updated_at: String,
      issue_customs: Array
    }
  end

  context '選択値に-1を指定して検索' do
    let(:params) do
      {
        'issue_customs': [
          {
            'issue_custom_item_id': single_select_item.id,
            'selected_values': ['-1']
          },
          {
            'issue_custom_item_id': multi_select_item.id,
            'selected_values': ['-1']
          }
        ]
      }
    end
    it '値未選択の課題が取得できる' do
      is_expected.to eq 200
      expect(response.body).to be_json_as(Array.new(6) { issue_response })
    end
  end

  context '複数の条件を指定して検索' do
    let(:params) do
      {
        'title': 'タイトルA',
        'issue_customs': [
          {
            'issue_custom_item_id': text_item.id,
            'text': 'テキストA'
          },
          {
            'issue_custom_item_id': single_select_item.id,
            'selected_values': ['1']
          },
          {
            'issue_custom_item_id': multi_select_item.id,
            'selected_values': ['1']
          }
        ]
      }
    end

    it '課題が取得できる' do
      pending("保留中")
      is_expected.to eq 200
      expect(response.body).to be_json_as(Array.new(3) { issue_response })
    end
  end
end

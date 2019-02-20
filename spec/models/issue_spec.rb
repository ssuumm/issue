require 'rails_helper'

RSpec.describe Issue, type: :model do
  describe 'Issue#search' do
    subject { Issue.search(condition) }

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
    let!(:single_select_item_option3) { create(:issue_custom_item_option, issue_custom_item_id: single_select_item.id, value: 3, label: '単一選択肢3', order_num: 30) }

    let!(:multi_select_item) { create(:issue_custom_item_multi_select, order_num: 30) }
    let!(:multi_select_item_option1) { create(:issue_custom_item_option, issue_custom_item: multi_select_item, value: 1, label: '複数選択肢1', order_num: 10) }
    let!(:multi_select_item_option2) { create(:issue_custom_item_option, issue_custom_item: multi_select_item, value: 2, label: '複数選択肢2', order_num: 30) }
    let!(:multi_select_item_option3) { create(:issue_custom_item_option, issue_custom_item: multi_select_item, value: 3, label: '複数選択肢3', order_num: 20) }

    let!(:issue1) { create_issue(title: 'タイトル1', content: '本文1', text: 'テキスト1') }
    let!(:issue2) { create_issue(title: 'タイトル2', content: '本文2', text: 'テキスト2', single_select_value: 1) }
    let!(:issue3) { create_issue(title: 'タイトル3', content: '本文3', text: 'テキスト3', single_select_value: 2) }
    let!(:issue4) { create_issue(title: 'タイトル4', content: '本文4', text: 'テキスト4', multi_select_values: [2]) }
    let!(:issue5) { create_issue(title: 'タイトル5', content: '本文5', multi_select_values: [1, 3]) }
    let!(:issue6) { create_issue(title: 'タイトル6', content: '本文6', text: 'テキスト6', single_select_value: 3, multi_select_values: [3]) }

    context 'タイトルで検索' do
      let(:condition) { { title: 'タイトル2' } }
      it 'タイトルが一致する課題のみ取得される' do
        expect(subject.pluck(:id)).to eq [issue2.id]
      end
    end

    context 'テキストカスタム項目で検索' do
      let(:condition) do
        {
          issue_customs: [
            {
              issue_custom_item_id: text_item.id,
              text: 'テキスト1'
            }
          ]
        }
      end
      it 'テキストカスタム項目が一致する課題のみ取得される' do
        expect(subject.pluck(:id)).to eq [issue1.id]
      end
    end

    context '単一選択カスタム項目で検索' do
      context '値を指定して検索' do
        let(:condition) do
          {
            issue_customs: [
              {
                issue_custom_item_id: single_select_item.id,
                selected_values: [2]
              }
            ]
          }
        end
        it '選択値が一致する課題のみ取得される' do
          expect(subject.pluck(:id)).to eq [issue3.id]
        end
      end

      context '選択値なし(nil)を指定して検索検索' do
        let(:condition) do
          {
            issue_customs: [
              {
                issue_custom_item_id: single_select_item.id,
                selected_values: [nil]
              }
            ]
          }
        end
        it '値が未選択の課題のみ取得される' do
          expect(subject.pluck(:id)).to match_array [issue1.id, issue4.id, issue5.id]
        end
      end

      context '値を複数指定して検索' do
        let(:condition) do
          {
            issue_customs: [
              {
                issue_custom_item_id: single_select_item.id,
                selected_values: [nil, 1]
              }
            ]
          }
        end
        it '条件に一致する課題のみ取得される' do
          expect(subject.pluck(:id)).to match_array [issue1.id, issue2.id, issue4.id, issue5.id]
        end
      end
    end

    context '複数選択カスタム項目で検索' do
      context '値を指定して検索' do
        let(:condition) do
          {
            issue_customs: [
              {
                issue_custom_item_id: multi_select_item.id,
                selected_values: [2]
              }
            ]
          }
        end
        it '選択値が一致する課題のみ取得される' do
          pending("保留中")
          expect(subject.pluck(:id)).to eq [issue4.id]
        end
      end

      context '選択値なし(nil)を指定して検索検索' do
        let(:condition) do
          {
            issue_customs: [
              {
                issue_custom_item_id: multi_select_item.id,
                selected_values: [nil]
              }
            ]
          }
        end
        it '値が未選択の課題のみ取得される' do
          pending("保留中")
          expect(subject.pluck(:id)).to match_array [issue1.id, issue2.id, issue3.id]
        end
      end

      context '値を複数指定して検索' do
        let(:condition) do
          {
            issue_customs: [
              {
                issue_custom_item_id: multi_select_item.id,
                selected_values: [nil, 1]
              }
            ]
          }
        end
        it '条件に一致する課題のみ取得される' do
          pending("保留中")
          expect(subject.pluck(:id)).to match_array [issue1.id, issue2.id, issue3.id, issue5.id]
        end
      end
    end

    context '複数の項目を同時に指定して検索' do
      let(:condition) do
        {
          title: 'タイトル6',
          issue_customs: [
            {
              issue_custom_item_id: text_item.id,
              text: 'テキスト6'
            },
            {
              issue_custom_item_id: single_select_item.id,
              selected_values: [3]
            },
            {
              issue_custom_item_id: multi_select_item.id,
              selected_values: [3]
            }
          ]
        }
      end
      it '条件に一致する課題のみ取得される' do
        expect(subject.pluck(:id)).to match_array [issue6.id]
      end
    end
  end
end

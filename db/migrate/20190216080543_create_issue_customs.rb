class CreateIssueCustoms < ActiveRecord::Migration[5.2]
  def change
    create_table :issue_customs do |t|
      t.integer :issue_id, null: false, comment: '課題ID'
      t.integer :issue_custom_item_id, null: false, comment: '課題カスタム項目ID'
      t.string :text, comment: 'テキスト項目の値'
      t.integer :selected_value, comment: '選択値(単一選択タイプ)'

      t.timestamps
    end
  end
end

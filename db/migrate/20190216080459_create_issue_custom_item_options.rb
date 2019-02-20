class CreateIssueCustomItemOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :issue_custom_item_options do |t|
      t.integer :issue_custom_item_id, null: false, comment: 'カスタム項目ID'
      t.string :label, null: false, comment: '選択肢の名称'
      t.integer :value, null: false, comment: '選択肢の値'
      t.integer :order_num, null: false, comment: '並び順'

      t.timestamps
    end
  end
end

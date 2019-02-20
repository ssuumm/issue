class CreateIssueCustomItems < ActiveRecord::Migration[5.2]
  def change
    create_table :issue_custom_items do |t|
      t.integer :item_type, null: false, comment: '項目タイプ'
      t.string :name, null: false, comment: '項目名'
      t.integer :order_num, null: false, comment: '並び順'

      t.timestamps
    end
  end
end

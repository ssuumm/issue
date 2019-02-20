class CreateIssueCustomDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :issue_custom_details do |t|
      t.integer :issue_custom_id, null: false, comment: '課題カスタム項目値ID'
      t.integer :value, null: false, comment: '選択値(複数選択タイプ)'

      t.timestamps
    end
  end
end

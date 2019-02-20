class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.string :title, comment: 'タイトル'
      t.text :content, comment: '本文'

      t.timestamps
    end
  end
end

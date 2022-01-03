class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.string :content, limit: 4096
      t.boolean :is_read, default: false, null: false

      t.timestamps
    end
  end
end

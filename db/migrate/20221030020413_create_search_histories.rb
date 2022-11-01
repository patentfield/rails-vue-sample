class CreateSearchHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :search_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.string :search_word

      t.timestamps
    end
  end
end

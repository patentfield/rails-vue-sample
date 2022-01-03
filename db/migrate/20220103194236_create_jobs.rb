class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.references :user, foreign_key: true
      t.text :params
      t.string :status
      t.string :job_id

      t.timestamps
    end
  end
end

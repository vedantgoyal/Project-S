class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.integer :project_id
      t.string :name
      t.float :amount

      t.timestamps
    end
  end
end

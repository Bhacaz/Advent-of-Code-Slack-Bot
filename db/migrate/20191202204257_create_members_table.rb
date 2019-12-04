class CreateMembersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.string :name
      t.integer :member_id
      t.integer :score
      t.integer :stars

      t.timestamps null: false
    end
  end
end

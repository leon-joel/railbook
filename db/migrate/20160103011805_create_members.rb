class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.integer :lock_version

      t.timestamps
    end
  end
end

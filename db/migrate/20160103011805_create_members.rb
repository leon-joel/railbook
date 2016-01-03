class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.integer :lock_version, default: 0
      # default値を追加

      t.timestamps
    end
  end
end

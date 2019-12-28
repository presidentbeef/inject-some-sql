class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.integer :age
      t.boolean :admin

      t.timestamps
    end
  end
end

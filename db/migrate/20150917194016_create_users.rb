class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :occupation
      t.string :email
      t.string :password
      t.integer :age
      t.string :hometown
      t.string :instrument

      t.timestamps null: false
    end
  end
end

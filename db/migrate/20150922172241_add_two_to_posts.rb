class AddTwoToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :two, :string
  end
end

class AddThreeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :three, :string
  end
end

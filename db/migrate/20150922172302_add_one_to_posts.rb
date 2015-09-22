class AddOneToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :one, :string
  end
end

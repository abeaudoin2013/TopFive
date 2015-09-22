class AddFourToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :four, :string
  end
end

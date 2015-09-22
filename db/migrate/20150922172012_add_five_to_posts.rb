class AddFiveToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :five, :string
  end
end

class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :posts, :body, :title
  end
end

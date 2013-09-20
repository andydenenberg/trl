class AddProductToPost < ActiveRecord::Migration
  def change
      add_column :posts, :product, :string
  end
end

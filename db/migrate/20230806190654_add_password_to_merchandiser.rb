class AddPasswordToMerchandiser < ActiveRecord::Migration[7.0]
  def change
    add_column :merchandisers, :password, :string
  end
end

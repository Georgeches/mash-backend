class AddUserTypeToMerchandisers < ActiveRecord::Migration[7.0]
  def change
    add_column :merchandisers, :user_type, :string
  end
end

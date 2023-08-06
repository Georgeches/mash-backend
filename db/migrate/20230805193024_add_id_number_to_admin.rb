class AddIdNumberToAdmin < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :id_number, :string
  end
end

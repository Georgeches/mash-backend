class CreateMerchandisers < ActiveRecord::Migration[7.0]
  def change
      create_table :merchandisers do |t|
      t.string :name
      t.string :id_number
      t.string :phone_number
      t.string :vehicle_registration
      t.string :status
      t.string :email
      t.string :profile_picture
      t.string :password_digest

      

      t.timestamps
    end
  end
end

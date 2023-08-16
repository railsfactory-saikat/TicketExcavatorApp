class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.references :excavator, null: false, foreign_key: true

      t.timestamps
    end
  end
end

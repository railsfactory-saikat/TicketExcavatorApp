class CreateServiceAreas < ActiveRecord::Migration[7.0]
  def change
    create_table :service_areas do |t|
      t.string :primary_sacode
      t.json :additional_sacodes
      t.references :ticket

      t.timestamps
    end
  end
end

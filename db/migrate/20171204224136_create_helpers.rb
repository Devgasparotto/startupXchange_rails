class CreateHelpers < ActiveRecord::Migration[5.1]
  def change
    create_table :helpers do |t|
    	t.int :individual_id

      	t.timestamps null: false
    end
  end
end

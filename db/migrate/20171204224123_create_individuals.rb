class CreateIndividuals < ActiveRecord::Migration[5.1]
  def change
    create_table :individuals do |t|
		t.string :source, limit: 3
		t.string :sourceID
		t.string :firstName
		t.string :lastName
		t.string :email
		t.boolean :isHelper
		t.boolean :isEntreprenuer
		
		t.timestamps null: false
    end
  end
end

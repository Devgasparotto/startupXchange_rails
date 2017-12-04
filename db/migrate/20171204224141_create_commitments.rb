class CreateCommitments < ActiveRecord::Migration[5.1]
  def change
    create_table :commitments do |t|
    	t.integer :helper_id
    	t.integer :entreprenuer_id
    	t.string :commitmentOffer
    	t.datetime :commitmentDueDate
    	t.integer :commitmentStatus_id

      	t.timestamps null: false
    end
  end
end

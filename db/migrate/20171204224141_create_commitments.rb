class CreateCommitments < ActiveRecord::Migration[5.1]
  def change
    create_table :commitments do |t|
    	t.int :helper_id
    	t.int :entreprenuer_id
    	t.string :commitmentOffer
    	t.datetime :commitmentDueDate
    	t.int :commitmentStatus_id

      	t.timestamps null: false
    end
  end
end

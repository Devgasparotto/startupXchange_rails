class CreateCommitmentStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :commitment_statuses do |t|
    	t.string :statusName
    	t.string :statusDescription

    	t.timestamps null: false
    end
  end
end

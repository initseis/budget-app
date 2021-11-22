class CreateGroupContracts < ActiveRecord::Migration[6.1]
  def change
    create_table :group_contracts do |t|
      t.references :contract, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :challenger_id, null: false
      t.integer :challengee_id, null: false
      t.timestamps null: false
    end
  end
end

class CreateSeekingProfiles < ActiveRecord::Migration
  def change
    create_table :seeking_profiles do |t|

      t.timestamps null: false
      t.belongs_to :user, index: true
    end
  end
end

class CreateGamerProfiles < ActiveRecord::Migration
  def change
    create_table :gamer_profiles do |t|

      t.timestamps null: false
      t.belongs_to :user, index: true


    end
  end
end

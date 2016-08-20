class AddColumnsToSeekProfile < ActiveRecord::Migration
  def change
    add_column :seeking_profiles, :minSeekDistance, :integer
    add_column :seeking_profiles, :maxSeekDistance, :integer
  end
end

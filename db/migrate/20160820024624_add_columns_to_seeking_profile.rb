class AddColumnsToSeekingProfile < ActiveRecord::Migration
  def change
    add_column :seeking_profiles, :minAge, :integer
    add_column :seeking_profiles, :maxAge, :integer
    add_column :seeking_profiles, :gender, :string
  end
end

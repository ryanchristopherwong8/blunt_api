class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :auth_token, default: ""
      t.integer :facebook_id, default: ""

      t.string :provider
      t.string :name
      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

    end

    add_index :users, :email, unique: true
    add_index :users, :facebook_id, unique: true
    add_index :users, :auth_token, unique: true
  
  end
end

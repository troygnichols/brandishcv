class CreateUser < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :remember_token
      t.boolean :admin, null: false, default: false
      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
    add_index :users, :remember_token, unique: true
  end

  def down
    drop_table :users
  end
end

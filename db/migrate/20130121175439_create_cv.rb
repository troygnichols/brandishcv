class CreateCv < ActiveRecord::Migration
  def up
    create_table :cvs do |t|
      t.references :user, null: false
      t.text :markdown
      t.datetime :created_at, null: false
    end
  end

  def down
    drop_table :cvs
  end
end

class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.string :description
      t.datetime :start
      t.datetime :end
      t.string :location
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end

class DropChefsTable < ActiveRecord::Migration
  def change
    drop_table :chefs
  end
end

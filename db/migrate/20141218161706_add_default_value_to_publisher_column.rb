class AddDefaultValueToPublisherColumn < ActiveRecord::Migration
  def change
    change_column :users, :publisher, :boolean, :default => false
  end
end

class AddRemindedToFiles < ActiveRecord::Migration[5.1]
  def change
    add_column :files, :reminded, :boolean, default: false
  end
end

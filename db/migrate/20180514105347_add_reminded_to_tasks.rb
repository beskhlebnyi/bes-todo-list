class AddRemindedToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :reminded, :boolean, default: false
  end
end

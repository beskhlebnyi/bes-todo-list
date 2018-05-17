class AddDeadlineColumnToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :deadline, :datetime, null: true
  end
end

class ChangeDeadlineToBeDateInTasks < ActiveRecord::Migration[5.1]
  def change
    change_column :tasks, :deadline, :date, null: false
  end
end

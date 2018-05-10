class ChangeDeadlineColumnParam < ActiveRecord::Migration[5.1]
  def change
    change_column :tasks, :deadline, :datetime, null: true
  end
end

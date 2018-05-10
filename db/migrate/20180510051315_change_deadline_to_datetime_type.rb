class ChangeDeadlineToDatetimeType < ActiveRecord::Migration[5.1]
  def change
    change_column :tasks, :deadline, :datetime
  end
end

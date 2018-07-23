class CreateFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :files do |t|
      t.string :content
      t.boolean :status
      t.belongs_to :list, foreign_key: true

      t.timestamps
    end
  end
end

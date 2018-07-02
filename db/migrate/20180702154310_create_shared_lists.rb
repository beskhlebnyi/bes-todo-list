class CreateSharedLists < ActiveRecord::Migration[5.2]
  def change
    create_table :shared_lists do |t|
      t.boolean :read_only
      t.belongs_to :user, foreign_key: true
      t.belongs_to :list, foreign_key: true

      t.timestamps
    end
  end
end

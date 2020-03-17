class AlterGramsAddUserId < ActiveRecord::Migration[5.2]
  def change
    unless column_exists?(:grams, :user_id)
      add_column :grams, :user_id, :integer
      add_index :grams, :user_id
    end
  end
end

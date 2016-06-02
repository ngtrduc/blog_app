class CreateNotis < ActiveRecord::Migration
  def change
    create_table :notis do |t|
      t.integer :noti_type
      t.boolean :status
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

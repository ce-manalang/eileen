class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.references :message, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end

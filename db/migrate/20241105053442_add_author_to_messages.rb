class AddAuthorToMessages < ActiveRecord::Migration[7.2]
  def change
    add_reference :messages, :author, null: false, foreign_key: { to_table: :users }
  end
end

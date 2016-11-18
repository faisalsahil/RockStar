class CreateUserSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :user_sessions do |t|
      t.string :auth_token
      t.integer :user_id

      t.timestamps
    end
  end
end

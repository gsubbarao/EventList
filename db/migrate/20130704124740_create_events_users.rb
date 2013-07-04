class CreateEventsUsers < ActiveRecord::Migration
  def change
    create_table :events_users do |t|
    	t.references :event
        t.references :user
    end
    add_index :events_users, [:event_id, :user_id]
    add_index :events_users, :user_id
  end
end

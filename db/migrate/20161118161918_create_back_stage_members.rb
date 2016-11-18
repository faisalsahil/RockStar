class CreateBackStageMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :back_stage_members do |t|
      t.string   :member_name
      t.integer  :event_id

      t.timestamps
    end
  end
end

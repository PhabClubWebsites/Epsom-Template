class AddAttachmentPoliciesOneToClubs < ActiveRecord::Migration
  def self.up
    change_table :clubs do |t|
      t.attachment :policies_one
    end
  end

  def self.down
    remove_attachment :clubs, :policies_one
  end
end

class AddAttachmentPoliciesFiveToClubs < ActiveRecord::Migration
  def self.up
    change_table :clubs do |t|
      t.attachment :policies_five
    end
  end

  def self.down
    remove_attachment :clubs, :policies_five
  end
end

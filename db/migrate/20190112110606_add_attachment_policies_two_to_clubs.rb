class AddAttachmentPoliciesTwoToClubs < ActiveRecord::Migration
  def self.up
    change_table :clubs do |t|
      t.attachment :policies_two
    end
  end

  def self.down
    remove_attachment :clubs, :policies_two
  end
end

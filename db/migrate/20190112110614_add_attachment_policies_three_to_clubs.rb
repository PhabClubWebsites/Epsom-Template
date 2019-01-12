class AddAttachmentPoliciesThreeToClubs < ActiveRecord::Migration
  def self.up
    change_table :clubs do |t|
      t.attachment :policies_three
    end
  end

  def self.down
    remove_attachment :clubs, :policies_three
  end
end

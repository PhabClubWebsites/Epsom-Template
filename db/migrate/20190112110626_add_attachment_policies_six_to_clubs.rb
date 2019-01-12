class AddAttachmentPoliciesSixToClubs < ActiveRecord::Migration
  def self.up
    change_table :clubs do |t|
      t.attachment :policies_six
    end
  end

  def self.down
    remove_attachment :clubs, :policies_six
  end
end

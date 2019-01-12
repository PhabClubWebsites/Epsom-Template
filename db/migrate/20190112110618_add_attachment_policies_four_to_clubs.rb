class AddAttachmentPoliciesFourToClubs < ActiveRecord::Migration
  def self.up
    change_table :clubs do |t|
      t.attachment :policies_four
    end
  end

  def self.down
    remove_attachment :clubs, :policies_four
  end
end

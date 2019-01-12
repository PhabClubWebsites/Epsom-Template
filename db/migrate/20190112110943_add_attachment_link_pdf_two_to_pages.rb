class AddAttachmentLinkPdfTwoToPages < ActiveRecord::Migration
  def self.up
    change_table :pages do |t|
      t.attachment :link_pdf_two
    end
  end

  def self.down
    remove_attachment :pages, :link_pdf_two
  end
end

class AddAttachmentPhotoToContacts < ActiveRecord::Migration
  def self.up
    change_table :contacts do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :contacts, :photo
  end
end

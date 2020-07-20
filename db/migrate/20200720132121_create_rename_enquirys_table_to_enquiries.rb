class CreateRenameEnquirysTableToEnquiries < ActiveRecord::Migration
  def change
    rename_table :enquirys, :enquiries
  end
end

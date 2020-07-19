class CreateEnquiries < ActiveRecord::Migration
  def change
    create_table :enquirys do |t|
      t.text :enquiry
      t.string :uid
      t.integer :customer_id
      t.integer :user_id
    end
  end
end

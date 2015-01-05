class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.string 	:name
      t.string	:company
      t.string 	:email
      t.string 	:phone
      t.text	  :job_description
      t.date 	  :finish_date
      t.timestamps
    end
  end
end

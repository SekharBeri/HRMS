class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :alternate_phone_number
      t.date :date_of_join
      t.float :salary
      t.float :yearly_salary
      t.float :tax_amount
      t.float :cess_amount
      t.timestamps
    end
  end
end



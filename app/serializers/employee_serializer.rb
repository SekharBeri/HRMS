class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :yearly_salary
  attributes :tax_amount, :cess_amount
end

class Api::V1::EmployeesController < ApplicationController
  before_action :employee, only: [:show]

  def create
    @employee = Employee.create(employee_params)
    if @employee.errors.empty?
      render_success_response({}, ["Employee created successfully"], [])
    else
      render_failure_response(@employee.errors)
    end
  end

  def show
    if employee.present?
      render_success_response(ActiveModelSerializers::SerializableResource.new(employee, serializer: EmployeeSerializer), [], [])
    else
      render_failure_response(["Unable to find the employee with given details"])
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :phone_number, :alternate_phone_number, :date_of_join, :salary)
  end

  def employee
    Employee.find_by(id: params[:id])
  end
end

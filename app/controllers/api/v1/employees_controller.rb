class Api::V1::EmployeesController < ApplicationController
  before_action :employee, only: [:show]

  def index
    @employees = Employee.all
    render_failure_response(["No employee data present"]) and return  if @employees.empty?

    render_success_response(array_json(@employees, EmployeeSerializer), ['employees loaded successfully.'], [])
  end

  def create
    @employee = Employee.create(employee_params)
    if @employee.errors.empty?
      render_success_response(@employee, ["Employee created successfully"], [])
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

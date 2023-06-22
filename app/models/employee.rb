class Employee < ApplicationRecord
  # data validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true
  validates :date_of_join, presence: true
  validates :salary, presence: true

  after_create :calculate_salary_and_tax

  def calculate_salary_and_tax
    months_salary = salary * number_of_months(self.date_of_join)
    remaining_days_salary = ((number_of_remaining_days(self.date_of_join) * salary) / 30) if number_of_months < 12
    total_salary = months_salary.to_f + remaining_days_salary.to_f
    tax_amount = calculate_tax(total_salary)
    cess_amount = calculate_cess(total_salary) if total_salary > 2500000
    self.update(yearly_salary: total_salary, tax_amount: tax_amount, cess_amount: cess_amount)
  end

  def calculate_tax(salary)
    tax = 0
    return tax if salary <= 250000

    if salary <= 500000
      tax = (salary - 250000) * 0.05
    elsif salary <= 1000000
      tax = 250000 * 0.05 + (salary - 500000) * 0.1
    else
      tax = 250000 * 0.05 + 500000 * 0.1 + (salary - 1000000) * 0.2
    end
    tax
  end

  def calculate_cess(total_salary)
    (total_salary - 2500000) * 0.2
  end

  def number_of_months(date_of_join)
    no_of_months = (year_last_date.year * 12 + year_last_date.month) - (date_of_join.year * 12 + date_of_join.month)
    no_of_months > 12 ? 12 : no_of_months
  end

  def number_of_remaining_days(date_of_join)
    Time.days_in_month(date_of_join.month, date_of_join.year) - date_of_join.day
  end

  def year_last_date
    current_time = Time.zone.now
    current_year = current_time.month > 3 ? current_time.year + 1 : current_time.year
    Date.parse("#{current_year}-03-31")
  end
end

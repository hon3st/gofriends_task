Employee.create!(
  email: ENV["EMPLOYEE_EMAIL"],
  password: ENV["EMPLOYEE_PASSWORD"],
  password_confirmation: ENV["EMPLOYEE_PASSWORD"]
)

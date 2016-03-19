def login_as_user
  visit root_path
  click_link "Войти с помощью Вконтакте"
end

def login_as_employee(employee)
  visit new_employee_session_path
  fill_in :employee_email, with: employee.email
  fill_in :employee_password, with: default_password
  click_button "Log in"
end

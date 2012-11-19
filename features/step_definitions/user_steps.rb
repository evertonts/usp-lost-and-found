# encoding: utf-8

def create_visitor
  @visitor ||= { :name => "Testy McUserton", :email => "example@example.com",
    :password => "please", :password_confirmation => "please" }
end

def find_user
  @user ||= User.first conditions: {:email => @visitor[:email]}
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
  visit '/users/sign_out'
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, email: @visitor[:email])
end

def create_other_user
  @other = FactoryGirl.create(:user, name: "Outro", email: "outro@mail.com")
end

def delete_user
  @user ||= User.first conditions: {:email => @visitor[:email]}
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/users/sign_up'
  within "#main" do
    fill_in I18n.t("activerecord.attributes.user.name"), :with => @visitor[:name]
    fill_in I18n.t("activerecord.attributes.user.email"), :with => @visitor[:email]
    fill_in I18n.t("activerecord.attributes.user.password"), :with => @visitor[:password]
    fill_in I18n.t("activerecord.attributes.user.password_confirmation"), 
    :with => @visitor[:password_confirmation]
  end  
  click_button I18n.t("devise.registrations.new.submit")
  find_user
end

def sign_in
  visit '/users/sign_in'
  within "#main" do
    fill_in I18n.t("activerecord.attributes.user.email"), :with => @visitor[:email]
    fill_in I18n.t("activerecord.attributes.user.password"), :with => @visitor[:password]
    click_button I18n.t("devise.sessions.new.submit")
  end
end

def create_other_users_item
  @item = FactoryGirl.create(:item, :user_id => @other.id, :lost_date => "21/02/2011", :description => "teste", :title => "teste")
end

def send_message message
  visit "/items/" + @item.id.to_s
  fill_in I18n.t("string.send_lost_message"), :with => message
  click_button "Enviar"
end

def send_contact_message
  visit "/contact/"
  fill_in "contact_message_body", :with => message
  click_button "Enviar"
end

### GIVEN ###
Given /^I am not logged in$/ do
  visit '/users/sign_out'
end

Given /^I am logged in$/ do
  create_user
  sign_in
  page.should have_content I18n.t("devise.sessions.signed_in")
end

Given /^I exist as a user$/ do
  create_user
end

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_user
end

### WHEN ###
When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I sign out$/ do
  visit '/users/sign_out'
end

When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "please123")
  sign_up
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end

When /^I edit my account details$/ do
  click_link "Editar Conta"
  fill_in I18n.t("activerecord.attributes.user.name"), :with => "newname"
  fill_in I18n.t("activerecord.attributes.user.current_password"), :with => @visitor[:password]
  click_button I18n.t("devise.registrations.edit.update")
end

When /^I look at the list of users$/ do
  visit '/'
end

When /^I visit my profile page$/ do
  visit "/users/" + @user.id.to_s
end

When /^I send a message to other user "(.*?)"$/ do |message|
  create_other_user
  create_other_users_item
  send_message(message)
end

When /^I send a contact message "(.*?)"$/ do |arg1|
  send_contact_message
end

When /^Someone send me a message$/ do
  create_other_user
  create_lost_item("Estojo", "material escolar")
  FactoryGirl.create(:message, :sender_id => @other.id, :recipient_id => @user.id, 
    :text => "Message", :item_id => Item.last.id)
  visit "/"
end

When /^i see this message$/ do
  visit "/users/" + @user.id.to_s
  find("#item-" + Item.last.id.to_s).click
  visit "/users/" + @user.id.to_s
end

### THEN ###
Then /^I should be signed in$/ do
  page.should have_content "Logout"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
end

Then /^I should be signed out$/ do
  page.should have_content "Cadastrar"
  page.should_not have_content "Logout"
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content I18n.t("devise.registrations.signed_up_but_unconfirmed")
end

Then /^I see a successful sign in message$/ do
  page.should have_content I18n.t("devise.sessions.signed_in")
end

Then /^I should see a successful sign up message$/ do
  page.should have_content I18n.t("devise.registrations.signed_up")
end

Then /^I should see an invalid email message$/ do
  page.should have_content I18n.t("errors.messages.invalid", :email)
end

Then /^I should see a missing password message$/ do
  page.should have_content I18n.t("errors.messages.blank", :password)
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content I18n.t("errors.messages.confirmation", :password)
end

Then /^I should see a mismatched password message$/ do
  page.should have_content I18n.t("errors.messages.confirmation", :password)
end

Then /^I should see a signed out message$/ do
  page.should have_content I18n.t("devise.sessions.signed_out")
end

Then /^I see an invalid login message$/ do
  page.should have_content I18n.t("devise.failure.invalid")
end

Then /^I should see an account edited message$/ do
  page.should have_content I18n.t("devise.registrations.updated")
end

Then /^I should see my name$/ do
  create_user
  page.should have_content @user[:name]
end

Then /^I should see an item "(.*?)"$/ do |item|
  page.should have_content(item)
end

Then /^I should see the sign in page$/ do
  page.should have_content "Para continuar, faça login ou registre-se."
  page.should have_content "Login"
  
end

Then /^I should see this message on my inbox "(.*?)"$/ do |message|
  visit "/users/" + @user.id.to_s
  page.should have_content(message)
end

Then /^I should see a contact message sended message$/ do
  page.should have_content("Sua mensagem foi enviada")
end

Then /^I should see a new message notification$/ do
  page.should have_content(@user.name + " (1)")
end

Then /^i shouldn't see a new message notification$/ do
  page.should_not have_content(@user.name + " (1)")
end




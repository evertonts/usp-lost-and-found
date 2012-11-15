# encoding: utf-8

def create_lost_item(description, tag)
  visit '/items/new_lost'
  fill_in "Título", :with => description
  fill_in "Descrição", :with => description
  fill_in "Recompensa", :with => 10.0
  fill_in "Data que o item foi perdido", :with => "21/09/2012"
  fill_in "item_tag_list", :with => tag
  click_button "Criar Item"
end

def create_found_item(description)
  visit '/items/new_found'
  fill_in "Título", :with => "novo item"
  fill_in "Descrição", :with => "novo item"
  fill_in "Data que o item foi encontrado", :with => "21/09/2012"
  click_button "Criar Item"
end

def recover_item(description)
  create_lost_item(description, "tag")
  visit '/items/1/edit'
  check('item_returned')
  click_button "Atualizar Item"
end

def search(description)
  visit "/"
  fill_in "item_search", :with => description
  click_button "buscar_perdido"
end

Given /^I have a lost item created "(.*?)"$/ do |item|
  create_lost_item(item, "tag")
end

Given /^I have a lost item "(.*?)" created with a tag "(.*?)"$/ do |item, tag|
  create_lost_item(item, tag)
end

Given /^There is another users item$/ do
  @user2 = FactoryGirl.create(:user, :name=>"user2", :email => "user2@example.com", 
    :password => "please", :password_confirmation => "please")
  @item2 = FactoryGirl.create(:item, :title => "new", :description => "item", :lost_date => "20/10/2012",
    :user_id => @user2.id)
end


When /^I create a new lost item "(.*?)"$/ do |item|
  create_lost_item(item, "tag")
end

When /^I create a new found item "(.*?)"$/ do |item|
  create_found_item(item)
end

When /^I mark an item as recovered "(.*?)"$/ do |item|
  recover_item(item)
end

When /^I search for "(.*?)"$/ do |item|
  search(item)
end

When /^I try to create a new lost item$/ do
  visit '/items/new_lost'
end

When /^I search for items tagged with "(.*?)"$/ do |tag|
  visit "/tags/" + tag
end

When /^I try to edit his item$/ do
  visit "/items/" + @item2.id.to_s + "/edit"
end


Then /^I should see an item created message$/ do
  page.should have_content "Item cadastrado com sucesso"
end

Then /^I should see an item recovered message$/ do
  page.should have_content "Item recuperado"
end

Then /^I should see "(.*?)"$/ do |item|
  page.should have_content(item)
end

Then /^I should see an acess denied message$/ do
  page.should have_content("Você não está autorizado a acessar esse recurso")
end



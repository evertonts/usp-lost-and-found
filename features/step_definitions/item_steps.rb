def create_lost_item(description)
  visit '/items/new_lost'
  fill_in "Descricao", :with => description
  fill_in "Recompensa", :with => 10.0
  select_date("1/1/2011", :from => "Data que o item foi perdido")
  click_button "Create"
end

def create_found_item(description)
  visit '/items/new_found'
  fill_in "Descricao", :with => "novo item"
  select_date("1/1/2011", :from => "Data que o item foi encontrado")
  click_button "Create"
end

def recover_item(description)
  create_lost_item(description)
  visit '/items/1/edit'
  check('item_returned')
  click_button "Update Item"
end

def search(description)
  visit "/"
  choose "perdido"
  fill_in "Search", :with => description
  click_button "Buscar"
end

Given /^I have a lost item created "(.*?)"$/ do |item|
  create_lost_item(item)
end

When /^I create a new lost item "(.*?)"$/ do |item|
  create_lost_item(item)
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

Then /^I should see an item created message$/ do
  page.should have_content "Item cadastrado com sucesso"
end

Then /^I should see an item recovered message$/ do
  page.should have_content "Item recuperado"
end

Then /^I should see "(.*?)"$/ do |item|
  page.should have_content(item)
end

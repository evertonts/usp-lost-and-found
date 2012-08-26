def create_lost_item
  visit 'items/new_lost'
  fill_in "Descricao", :with => "novo item"
  fill_in "Recompensa", :with => 10.0
  select_date("1/1/2011", :from => "Data que o item foi perdido")
  click_button "Create"
end

def create_found_item
  visit 'items/new_found'
  fill_in "Descricao", :with => "novo item"
  select_date("1/1/2011", :from => "Data que o item foi encontrado")
  click_button "Create"
end

def recover_item
  create_lost_item
  visit '/items/1/edit'
  check('item_returned')
  click_button "Update Item"
end

When /^I create a new lost item$/ do
  create_lost_item
end

When /^I create a new found item$/ do
  create_found_item
end

When /^I mark an item as recovered$/ do
  recover_item
end

Then /^I should see an item created message$/ do
  page.should have_content "Item cadastrado com sucesso"
end

Then /^I should see an item recovered message$/ do
  page.should have_content "Item recuperado"
end

def create_lost_item
  visit 'items/new_lost'
  fill_in "Descricao", :with => "novo item"
  select_date("1/1/2011", :from => "Data que o item foi perdido")
  click_button "Create"
end

def create_found_item
  visit 'items/new_found'
  fill_in "Descricao", :with => "novo item"
  select_date("1/1/2011", :from => "Data que o item foi encontrado")
  click_button "Create"
end

When /^I create a new lost item$/ do
  create_lost_item
end

When /^I create a new found item$/ do
  create_found_item
end

Then /^I should see an item created message$/ do
  page.should have_content "Item cadastrado com sucesso"
end

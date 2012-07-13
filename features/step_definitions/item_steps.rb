def create_item
  visit "/items/new"
  fill_in "Descricao", :with => "novo item"
  select_date("1/1/2011", :from => "Data que o item foi perdido")
  click_button "Create"
end


When /^I create a new lost item$/ do
  create_item
end

Then /^I should see an item created message$/ do
  page.should have_content "Item cadastrado com sucesso"
end

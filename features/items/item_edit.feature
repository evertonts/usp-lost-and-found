Feature: Edit item

	As a registred site user
	I want to edit an item
	
	Scenario: User recover a lost item
  	Given I am logged in
		And I create a new lost item "item 1"
		When I mark an item as recovered "item 1"
		Then I should see an item recovered message
		
	Scenario: User should not be able to edit other users items
		Given I am logged in
		And There is another users item
		When I try to edit his item
		Then I should see an acess denied message
Feature: Edit item

	As a registred site user
	I want to edit an item
	
	Scenario: User recover a lost item
  	Given I am logged in
		When I mark an item as recovered
		Then I should see an item recovered message
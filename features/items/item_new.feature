Feature: Create item

	As a registred site user
	I want to report a lost item
	
	Scenario: User report a lost item
  	Given I am logged in
		When I create a new lost item
		Then I should see an item created message
		 
		
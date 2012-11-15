Feature: Create item

	As a registred site user
	I want to report a lost item
	
	Scenario: User report a lost item
  	Given I am logged in
		When I create a new lost item "lost item 1"
		Then I should see an item created message
		 
	Scenario: User report a found item
  	Given I am logged in
		When I create a new found item "found item 1"
		Then I should see an item created message
		
	Scenario: Visitors should not be able to create an item
		Given I am not logged in
		When I try to create a new lost item
		Then I should see the sign in page
  	
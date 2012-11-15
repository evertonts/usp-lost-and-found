@search
Feature: Search items

	As a site user
	I want to search for items
	
	Scenario: User searchs for  a lost item
		Given I am logged in
  	And I have a lost item created "lost item 1"
		When I search for "lost item 1"
		Then I should see "lost item 1"
		
	Scenario: User searchs for tagged items
		Given I am logged in
	 	And I have a lost item "lost item 1" created with a tag "tag1"
		When I search for items tagged with "tag1"
		Then I should see "lost item 1"

Feature: Show Users
  As a user of the website
  I want to see my profile page
 
    Scenario: Viewing profile
      Given I exist as a user
			When I sign in with valid credentials
			And I create a new lost item "my item"
      And I visit my profile page
      Then I should see my name
			And I should see an item "my item"

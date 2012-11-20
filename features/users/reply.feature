Feature: Send replies
  As a user of the website
  I want to be able reply my messages

	Scenario: User receive new reply
		Given I am logged in
		When Someone send me a reply
		Then I should see a new message notification
	
	@javascript
	Scenario: User see a new message
		Given I am logged in
		And Someone send me a reply
		When i see this reply
		Then i shouldn't see a new message notification
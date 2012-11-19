Feature: Send messages
  As a user of the website
  I want to be able to send messages to other users
	
	Scenario: User send message
		Given I am logged in
		When I send a message to other user "Olá"
		Then I should see this message on my inbox "Olá"
		
	Scenario: User receive new message notification
		Given I am logged in
		When Someone send me a message
		Then I should see a new message notification
	
	@javascript
	Scenario: User see a new message
		Given I am logged in
		And Someone send me a message
		When i see this message
		Then i shouldn't see a new message notification
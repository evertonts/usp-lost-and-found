Feature: Send messages
  As a user of the website
  I want to be able to send messages to other users
	
	Scenario: User send message
		Given I am logged in
		When I send a message to other user "Olá"
		Then I should see this message on my inbox "Olá"
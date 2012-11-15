Feature: Contact the website admins
  As a user of the website
  I want to be able to send messages to the site admins
	
	Scenario: User send contact message
		Given I am logged in
		When I send a contact message "Olá"
		Then I should see a contact message sended message
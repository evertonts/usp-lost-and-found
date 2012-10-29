# Load the rails application
require File.expand_path('../application', __FILE__)

app_variables = File.join(Rails.root, 'config', 'app_variables.rb')
load(app_variables) if File.exists?(app_variables)

# Initialize the rails application
UspLostAndFound::Application.initialize!

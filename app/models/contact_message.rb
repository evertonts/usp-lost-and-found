class ContactMessage < ActiveRecord::Base
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :body

  validates :name, :email, :body, :presence => true
  validates :email, :format => { :with => %r{.+@.+\..+} }, :allow_blank => true

  def persisted?
    false
  end
end

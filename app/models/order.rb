class Order < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :destgroups
  
   has_many :order_attachments
    accepts_nested_attributes_for :order_attachments, allow_destroy: true
end
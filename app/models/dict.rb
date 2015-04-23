# encoding: utf-8
class Dict < ActiveRecord::Base
  # attr_accessible :code, :dict_type, :name

  def to_option
    [name, id]
  end
  
end
# == Schema Information
#
# Table name: dicts
#
#  id         :integer(38)     not null, primary key
#  name       :string(255)
#  dict_type  :string(255)
#  code       :integer(38)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#


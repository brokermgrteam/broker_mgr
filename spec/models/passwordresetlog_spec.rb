require 'spec_helper'

describe Passwordresetlog do
  pending "add some examples to (or delete) #{__FILE__}"
end
# == Schema Information
#
# Table name: passwordresetlogs
#
#  id           :integer(38)     not null, primary key
#  user_id      :integer(38)
#  confirm_code :string(255)
#  mobile       :string(255)
#  status       :integer(38)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#


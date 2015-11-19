# encoding: utf-8
class Brokertraininglog < ActiveRecord::Base
  attr_accessible :collectdate, :exammark, :examname, :idcard, :ispass, :passtime, :usercode
end

# encoding: utf-8
# == Schema Information
#
# Table name: users
#
#  id                 :integer(38)     not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean(1)      default(FALSE)
#  usercode           :string(255)
#  branch_id          :integer(38)
#  department_id      :integer(38)
#  status             :integer(38)
#  user_type          :integer(38)
#  first_login        :boolean(1)      default(TRUE)
#

class User < ActiveRecord::Base
  attr_accessor   :password
  attr_accessible :name, :email, :password, :usercode, :password_confirmation, :userposition_ids,
                  :role_ids, :branch_id, :department_id, :status, :failed_times

  belongs_to :branch
  belongs_to :department

  has_many :notices
  has_many :massages
  has_many :sessions
  has_many :assignments
  has_many :usersigns
  has_many :roles, :through => :assignments
  has_many :userpositionrels, :dependent => :destroy,
                              :foreign_key => "userid"
  has_many :userpositions, :through => :userpositionrels,
                           :source => :position
  has_many :readnotices
  has_many :notices, :through => :readnotices

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  password_regex = /^(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$/

  validates :name,  :presence   => true,
                    :length     => { :maximum => 20 }
  validates :usercode, :presence   => true,
                       :uniqueness => true
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 8..20 },
                       :format => {:with => password_regex, message: "至少8位数字、符号与大小写字母组合"}

  before_save :encrypt_password

  # default_scope  :order => 'users.usercode'

  scope :valid_user, where(:status => Dict.find_by_dict_type_and_code("UserBase.status", 1) )

  def to_label
    "#{usercode} | #{name}"
  end

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def has_default_password?(submitted_password)
    encrypted_password == submitted_password
  end

  def position!(position)
    userpositionrels.create!(:positionid => position.id )
  end

  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end

  def has_position?(position_sym)
    userpositions.any? { |p| p.name.underscore.to_sym == posposition_symition }
  end

  def unlock
    self.update_attribute :status, Dict.find_by_dict_type_and_code("UserBase.status", 1).id
  end

  class << self
    def authenticate(usercode, submmited_password)
      user = User.find_by_usercode_and_status(usercode, Dict.find_by_dict_type_and_code("UserBase.status", 1))
      # if user && user.first_login?
      #   (user && user.has_default_password?(submmited_password)) ? user : nil
      # else
        (user && user.has_password?(submmited_password)) ? user : nil
      # end
      # 与上面相同
      # return nil  if user.nil?
      # return user if user.has_password?(submmited_password)
    end

    def authenticate_with_salt(id, cookie_salt)
      user = find_by_id(id)
      (user && user.salt == cookie_salt) ? user : nil
    end
  end


  #encrypted password method
  private
    def encrypt_password
      self.salt = make_salt if (new_record? || self.salt.nil?)
      if password != nil
        self.encrypted_password = encrypt(password)
      end
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end

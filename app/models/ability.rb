# encoding: utf-8
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # in case of guest
    
    alias_action :create, :read, :update, :destroy, :to => :crud
    
    if user.has_role? :系统管理员
      can :manage, :all
      can :access_user_first_page, :all
      cannot :access_broker_first_page, :all

    elsif user.has_role? :营业部管理
      can :access_user_first_page, :all
      can :read, Branch, :id => user.branch_id
      can :read, User,   :branch_id => user.branch_id
      can :update, User,   :branch_id => user.branch_id
      can :manage, Broker, :branch_id => user.branch_id
      can :read, Custservvisit
      can :read, Workflowhistory
      can :read, Product
      can :downloadfile, Product
      can :read, Cust, :branch_id => user.branch_id
      can :productcusts_index, Cust, :branch_id => user.branch_id
      can :read, Channel
      can :create, Channelurl
      
    elsif user.has_role? :分公司管理
      can :access_user_first_page, :all
      can :read, Department, :id => user.department_id
      can :read, Branch, :department_id => user.department_id
      can :read, User,   :department_id => user.department_id
      can :update, User,   :department_id => user.department_id
      can :manage, Broker, :branch_id => user.department.branches.map {|b| b.id}
      can :read, Custservvisit
      can :read, Workflowhistory
      can :read, Product
      can :downloadfile, Product
      can :read, Cust, :branch_id => user.department.branches.map {|b| b.id}
      can :productcusts_index, Cust, :branch_id => user.department.branches.map {|b| b.id}
      can :read, Channel
      can :create, Channelurl

    elsif user.has_role? :销售交易部管理
      can :access_user_first_page, :all
      can :read, Department
      can :read, Branch
      can :manage, User
      can :manage, Role
      can :manage, Userposition
      can :manage, Workflow
      can :manage, Broker
      can :read, Custservvisit
      can :read, Workflowhistory
      can :read, Product
      can :downloadfile, Product
      can :read, Cust
      can :productcusts_index, Cust
      can :manage, Channel
      can :create, Channelurl
      
    elsif user.has_role? :营销人员
      can :access_broker_first_page, :all
      can :read, Branch, :id => user.branch_id
      can :read, User,   :id => user.id
      can :update, User,   :id => user.id
      can :read, Broker, :id => Broker.find_by_user_id(user.id).id
      can :crud, Custservvisit
      can :crud, Workflowunderway
      can :read, Workflowhistory
      can :read, Cust, :branch_id => user.branch_id
      can :read, Product
      can :downloadfile, Product
      can :productcusts_index, Cust, :branch_id => user.branch_id
    else
      # can :read, :all
    end
  end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
end

class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include DepartmentsHelper
  include DeptindicesHelper
  include DictsHelper
  include WorkflowunderwaysHelper
  include NoticesHelper
  # include SalariesHelper
  # include BrokersHelper

  rescue_from(CanCan::AccessDenied) {
    # raise(CanCan::AccessDenied 'Invalid access request')
    deny_access
  }
end

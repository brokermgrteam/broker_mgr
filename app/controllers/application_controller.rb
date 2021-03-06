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
    # raise(CanCan::AccessDenied, 'Invalid access request')
    deny_access
  }

  # rescue_from Exception, with: :render_error
  #
  #   def render_error(exception)
  #       respond_with do |format|
  #           format.html { raise exception }
  #           format.json { raise exception }
  #           format.js { render 'errors/error' }
  #       end
  #   end
end

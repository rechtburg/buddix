class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :set_root_title

  def set_root_title
    @root_title = "BuddiX (バディックス)"
  end

  #exception
  rescue_from AcriveRecord::RecordNotFound, with: :error_404_not_found
  rescue_from ActionController::RoutingError, with: :error_404_not_found

  rescue_from Exception, with: :error_500_internal_server_error
  rescue_from CustomNotFound, with: :error_404_not_found
  rescue_from CustomForbidden, with: :error_403_forbidden
  rescue_from CustomClientError, with: :error_400_invalied


  def error_404_not_found(exception=nil)
    logger.debug "# error_404_not_found"

    if exception
      logger.debug "#{exception.class}:#{exception.message}"
      logger.debug exception.backtrace.first
    end

    @error_title = '404 error'

    render template: 'errors/404_not_found', status: 404, layout:'application', content_type: 'text/html'
  end

  def error_500_internal_server_error(exception=nil)
    logger.debug "# error_500_internal_server_error"

    if exception
      logger.debug "#{exception.class}:#{exception.message}"
      logger.debug exception.backtrace.first
    end

    @error_title = '500 error'
    @msg = "サーバーでエラーが起こりました"

    render template: 'errors/500_internal_server_error', status: 500, layout:'application', content_type: 'text/html'
  end

  def error_403_forbidden(exception=nil)
    logger.debug "# error_403_forbidden"
    if exception
      logger.debug "#{exception.class}:#{exception.message}"
      logger.debug exception.backtrace.first
    end

    @error_title = '403 error'

    render template: 'errors/403_forbidden', status: 403, layout:'application', content_type: 'text/html'
  end

  def error_400_invalied(exception=nil)
    logger.debug "# error_400_invalied"
    if exception
      logger.debug "#{exception.class}:#{exception.message}"
      logger.debug exception.backtrace.first
    end

    @error_title = '400_error'
    @msg = exception.class.to_s == exception.message? "不正なアクセス" : exception.message

    render template: 'errors/400_invalid', status:400, layout:'application', content_type: 'text/html'
  end
end

class FailuresController < ApplicationController
  before_filter :require_admin
  layout "admin"

  helper :sort
  include SortHelper

  def index
    sort_init "created_on desc"
    sort_update %w(name created_on)

    scope = Failure.order("id desc")
###    scope = scope.like(params[:name]) if params[:name].present?
###    scope = scope.in_group(params[:group_id]) if params[:group_id].present?

    @limit = per_page_option
    @failure_count = scope.count
    @failure_pages = Paginator.new self, @failure_count, @limit, params['page']
    @offset ||= @failure_pages.current.offset
    @failures =  scope.order(sort_clause).limit(@limit).offset(@offset)

###    render :layout => !request.xhr?
  end
end

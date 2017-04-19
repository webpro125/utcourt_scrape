module ApplicationHelper
  def page_class_active (controller, action='')
    action == '' ? (params[:controller] == controller ? 'active' : '') : (params[:controller] == controller && params[:action] == action ? 'active' : '')
  end
end
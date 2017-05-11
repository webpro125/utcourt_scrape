module ApplicationHelper
  def page_class_active (controller, action='')
    action == '' ? (params[:controller] == controller ? 'active' : '') : (params[:controller] == controller && params[:action] == action ? 'active' : '')
  end

  def is_active_controller(controller_name)
    params[:controller] == controller_name ? "active" : nil
  end

  def is_active_action(action_name)
    params[:action] == action_name ? "active" : nil
  end

  def human_boolean(boolean)
    boolean ? 'Yes' : 'No'
  end
end
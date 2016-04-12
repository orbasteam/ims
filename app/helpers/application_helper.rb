module ApplicationHelper

  def gender(sex)
    sex.to_i == 0 ? '先生' : '小姐'
  end

  def form_action(back_url)
    link_to('Back', back_url, class: 'btn btn-default') + " " +
    submit_tag('送出', class: 'btn btn-primary')
  end

  def in_edit?
    ['edit', 'update'].include? action_name
  end

  def nav_li(name, path)
    path_separate = Rails.application.routes.recognize_path(path)
    klass = path_separate[:controller] == controller_name ? 'active' : nil
    content_tag :li, class: klass do
      link_to name, path
    end
  end

end

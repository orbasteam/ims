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

end

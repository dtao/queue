module ApplicationHelper
  def page_identifier
    "#{params[:controller]}-#{params[:action]}"
  end

  def render_partial(name, data={})
    render(:partial => "partials/#{name}", :locals => data)
  end

  def nav_menu
    render_partial('nav_menu')
  end

  def nav_link(text, path)
    content_tag(:li, :class => current_page?(path) ? 'active' : nil) do
      link_to(text, path)
    end
  end

  def notice
    render_partial('notice', :type => flash[:notice_type], :message => flash[:notice])
  end

  def form_field(name, type=:text)
    render_partial('form_field', :field => name, :type => type)
  end

  def form_submit(text)
    render_partial('form_submit', :text => text)
  end
end

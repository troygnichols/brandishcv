module ApplicationHelper

  def markdown(text)
    markdown_renderer.render(text).html_safe
  end

  def datatable_for(entity_type, opts = {})
    route = { controller: 'datatables', action: entity_type }.merge(opts[:extra_params] || {})
    render 'datatables/datatable', entity_type: entity_type, fields: opts[:fields],
           data_source: opts[:data_source] || url_for(route),
           search_columns: opts[:search_columns]
  end

  def flash_css_class_for(kind)
    case kind
    when 'notice'
      'success'
    when 'error'
      'alert'
    else kind
    end
  end

  def random_username
    User.select(:username).joins(:cvs).sample.try(:username)
  end

  private

    def markdown_renderer
      @markdown_renderer || create_markdown_renderer
    end

    def create_markdown_renderer
      @markdown_renderer = Redcarpet::Markdown.new(
          Redcarpet::Render::HTML,
          :autolink => true, :space_after_headers => true)
    end

end

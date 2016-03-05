module ApplicationHelper

  def site_title_text
    ENV["SITE_TITLE"] || "Ask a Cuban"
  end

  def seo_title_text
    ENV["SEO_TITLE"] || "Ask a Cuban"
  end

  def link_to_list_item(name, link, options={})
    options = current_page?(link) ? {class: "active"} : {}
    content_tag :li, options do
      link_to name, link, options
    end

  end
end

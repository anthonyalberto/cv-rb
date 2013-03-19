class CandidateDecorator < Draper::Decorator
  #delegates_all
  #Consider refactoring to remove Draper dependency ... This class doesn't do much really.
  SECTIONS = %W{general_information skills education work_experience open_source internet_profiles cats funny_links hobbies credits}

  def sections
    h.instructions do
      h.success(I18n.t("shell.instructions.sections_success", sections: format_sections))
    end
  end

  def cv
    h.instructions do
      I18n.t("shell.instructions.title_cheat")
    end
  end

  def format_sections
    h.content_tag(:span, SECTIONS.join(", "), class: "methods_text")
  end

  def markdown
    @markdown_object ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                                 :autolink => true, :space_after_headers => true)
  end

  def ul_additional_information
    hash = { I18n.t("candidate.languages") => source.languages, I18n.t("candidate.current_location") => source.current_location, I18n.t("candidate.current_status") => source.current_status, I18n.t("candidate.email") => source.email, I18n.t("candidate.phone") => source.phone }
    h.content_tag :ul do
      hash.each do |k, v|
        h.concat h.content_tag :li, h.strong_then_normal(k, v)
      end
    end
  end

  private
  def method_missing(name, *args, &block)
    string_name = name.to_s
    if string_name.in? SECTIONS
      h.render(partial: "/candidate/#{string_name}", locals: { candidate: source, decorator: self, section: string_name }).html_safe
    else
      super
    end
  end

end

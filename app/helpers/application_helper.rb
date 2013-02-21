module ApplicationHelper

  def render_result(result)
    (ap(result).gsub(/<([^>]*:0x[^>]*)>/, '\1')).to_json
  end
end

module ApplicationHelper

  def render_result(result)
    (ap(result).gsub(/<([^>]*:0x[^>]*)>/, '\1')).to_json
  end

  def fork_me_tag
    link_to "https://github.com/anthonyalberto/cv-rb", id: "fork_me", target: "_blank" do
      image_tag "https://s3.amazonaws.com/github/ribbons/forkme_right_green_007200.png", alt: "Fork me on GitHub"
    end
  end

  def logout_button
    content_for(:logout) do
      link_to "Logout", destroy_recruiter_session_path, method: :delete, class: "btn", id: "logout"
    end
  end
end

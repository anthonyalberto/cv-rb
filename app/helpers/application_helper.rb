module ApplicationHelper

  def render_result(result, status)
    instructions = ""
    if result.is_a? String
      return result.to_json
    elsif result.is_a? CandidateDecorator
      if status == "assignment"
        instructions = success("Alright. Let's find out what methods are available on this handy decorator. Call the 'sections' method on your decorator variable to find out.")
      else
        instructions = "Almost! Make sure you assign the decorator to a variable. For example, decorator = candidate.decorate"
      end
    elsif result.is_a? Candidate
      if status == "assignment"
        instructions = success("Great! Now, let's instantiate a decorator that will allow us to format our data. To do this, simply call the 'decorate' method on your candidate variable and store the result in a variable.")
      else
        instructions = "Almost! Make sure you assign the Candidate to a variable. For example, candidate = Candidate..."
      end
    elsif result.is_a? ActiveRecord::Relation
      instructions = "Make sure you call the 'first' method on the collection returned by the 'where' method."
    end
    (render_object(result) + instructions { instructions }).to_json
  end

  def render_object(object)
    begin
      (ap(object).gsub(/<([^>]*:0x[^>]*)>/, '\1'))
    rescue Exception => e
      object.inspect.gsub(/</, '&lt;').gsub(/>/, '&gt;') rescue ap e
    end
  end

  def success(message)
    content_tag(:span, message.html_safe, class: "success_message")
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

  def reset_shell_button
    link_to "Reset Shell", "#reset", class: "btn btn-danger top_button", id: "reset_shell"
  end

  def view_db_schema_button
    link_to "DB Schema", asset_path("schema.svg"), target: "_blank", class: "btn top_button"
  end

  def instructions
    (content_tag "div", class: "instructions" do
      yield
    end).html_safe
  end

  def strong_then_normal(strong, normal)
    content_tag :span do
      content_tag('strong', strong) + " #{normal}"
    end
  end
end

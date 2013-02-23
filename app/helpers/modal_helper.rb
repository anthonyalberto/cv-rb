module ModalHelper

  def modal_tag
    content_tag "div", class: "modal hide fade" do
      yield
    end
  end

  def modal_header
    content_tag "div", class: "modal-header" do
      concat content_tag("button",  "&times;".html_safe, class: "close", "data-dismiss" => "modal", "aria-hidden" => "true")
      yield
    end
  end

  def modal_body
    content_tag "div", class: "modal-body" do
      yield
    end
  end


  def modal_image_tag(name)
    image_tag "candidate/#{name.to_s}.jpg", class: "img-rounded", height: 200
  end

end
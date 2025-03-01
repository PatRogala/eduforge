# Lookbook preview for Flash::FlashMessageComponent
class FlashComponentPreview < ViewComponent::Preview
  def notice_message
    render(Flash::FlashMessageComponent.new(notice: "This is notice", alert: nil))
  end

  def alert_message
    render(Flash::FlashMessageComponent.new(notice: nil, alert: "This is alert"))
  end
end

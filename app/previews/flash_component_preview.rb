# Lookbook preview for Flash::FlashMessageComponent
class FlashComponentPreview < ViewComponent::Preview
  def notice_message
    render(Flash::FlashMessageComponent.new(notice: "Twój profil został zaktualizowany", alert: nil))
  end

  def alert_message
    render(Flash::FlashMessageComponent.new(notice: nil, alert: "Nieprawidłowe dane"))
  end
end

module Flash
  # Flash message shown at the right top of the page
  class FlashMessageComponent < ViewComponent::Base
    attr_reader :notice, :alert

    def initialize(notice:, alert:)
      super
      @notice = notice
      @alert = alert
    end
  end
end

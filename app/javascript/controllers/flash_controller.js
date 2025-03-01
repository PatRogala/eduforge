import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["message"]
  static values = {
    hideAfter: Number
  }

  connect() {
    setTimeout(() => {
      this.messageTarget.classList.remove('translate-x-full', 'opacity-0')
      this.messageTarget.classList.add('translate-x-0', 'opacity-100')

      if (this.hasHideAfterValue) {
        setTimeout(() => {
          this.messageTarget.classList.remove('translate-x-0', 'opacity-100')
          this.messageTarget.classList.add('translate-x-full', 'opacity-0')
          
          setTimeout(() => {
            this.element.remove()
          }, 500)
        }, this.hideAfterValue)
      }
    }, 100)
  }
}
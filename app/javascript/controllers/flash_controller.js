import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["message"]
  static values = {
    hideAfter: Number,
    visible: { type: Boolean, default: false }
  }

  connect() {
    setTimeout(() => {
      this.show()
    }, 50)

    if (this.hasHideAfterValue) {
      this.timer = setTimeout(() => {
        this.hide()
      }, this.hideAfterValue)
    }
  }

  disconnect() {
    if (this.timer) {
      clearTimeout(this.timer)
    }
  }

  show() {
    if (this.visibleValue) return

    this.messageTarget.classList.remove('translate-x-full', 'opacity-0')
    this.messageTarget.classList.add('translate-x-0', 'opacity-100')
    this.visibleValue = true
  }

  hide() {
    if (!this.visibleValue) return

    if (this.timer) {
      clearTimeout(this.timer);
      this.timer = null;
    }

    this.messageTarget.classList.remove('translate-x-0', 'opacity-100')
    this.messageTarget.classList.add('translate-x-full', 'opacity-0')
    this.visibleValue = false

    setTimeout(() => {
      this.element.remove()
    }, 500)
  }

  close() {
    this.hide()
  }
}

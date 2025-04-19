import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["element"]

  connect() {
    console.log("toggle controller connected")
  }

  toggle(event) {
    this.elementTargets.forEach(element => {
      element.classList.toggle("hidden")
    })
  }
}

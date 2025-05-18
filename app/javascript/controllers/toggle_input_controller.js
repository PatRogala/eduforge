// app/javascript/controllers/toggle_input_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["inputArea", "toggleButtonText"]
  static values = { initialText: String, alternativeText: String }
  static classes = ["hidden"]

  connect() {
    this.isInputAreaVisible = !this.inputAreaTarget.classList.contains(this.hiddenClass);
    this.updateButtonText();
  }

  toggle(event) {
    event.preventDefault()
    this.inputAreaTarget.classList.toggle(this.hiddenClass)
    this.isInputAreaVisible = !this.inputAreaTarget.classList.contains(this.hiddenClass);

    // If revealing the input, clear the select dropdown
    if (this.isInputAreaVisible) {
      const selectElement = this.element.querySelector('select[name*="programming_course_chapter_id"]')
      if (selectElement) {
        selectElement.value = "" // Clear selection
      }
    }
    this.updateButtonText();
  }

  selectChanged(event) {
    // If a chapter is selected from dropdown, hide the new chapter input field
    if (event.target.value !== "") {
      this.inputAreaTarget.classList.add(this.hiddenClass)
      this.isInputAreaVisible = false;
    }
    this.updateButtonText();
  }

  updateButtonText() {
    if (this.hasToggleButtonTextTarget) {
      // You'll need to pass these via data attributes on the controller if you want dynamic button text.
      // For simplicity, I'll use the same text for now from the translations.
      // Example: data-toggle-input-initial-text-value="Create new" data-toggle-input-alternative-text-value="Select existing"
      // this.toggleButtonTextTarget.textContent = this.isInputAreaVisible ? this.alternativeTextValue : this.initialTextValue;
    }
  }
}

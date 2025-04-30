import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "aside", "button"]

  static values = {
    collapsed: { type: Boolean, default: false }
  }

  // Class mappings for different states
  static classes = {
    content: {
      collapsed: "hidden",
    },
    aside: {
      collapsed: ["w-0", "md:w-16"],
      expanded: "w-64"
    },
    button: {
      expanded: "mr-3"
    }
  }

  connect() {
    // Initialize from localStorage or default
    this.collapsedValue = localStorage.getItem("sidebarCollapsed") === "true"
  }

  toggle() {
    this.collapsedValue = !this.collapsedValue
    localStorage.setItem("sidebarCollapsed", this.collapsedValue)
  }

  collapsedValueChanged() {
    this.#updateContentVisibility()
    this.#updateButtonSpacing()
    this.#updateAsideWidth()
  }

  // Private methods for updating different parts of the sidebar
  #updateContentVisibility() {
    this.contentTargets.forEach(target => {
      target.classList.toggle(this.constructor.classes.content.collapsed, this.collapsedValue)
    })
  }

  #updateButtonSpacing() {
    this.buttonTargets.forEach(target => {
      target.classList.toggle(this.constructor.classes.button.expanded, !this.collapsedValue)
    })
  }

  #updateAsideWidth() {
    const { collapsed, expanded } = this.constructor.classes.aside
    if (this.collapsedValue) {
      this.asideTarget.classList.add(...collapsed)
      this.asideTarget.classList.remove(expanded)
    } else {
      this.asideTarget.classList.remove(...collapsed)
      this.asideTarget.classList.add(expanded)
    }
  }
}

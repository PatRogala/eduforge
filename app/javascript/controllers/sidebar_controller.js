import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "aside", "button"]
  itemCollapsedClass = "hidden"
  asideCollapsedClasses = ["w-0", "md:w-16"]
  asideExpandedClass = "w-64"
  buttonExpandedClass = "mr-3"

  connect() {
    const isCollapsed = localStorage.getItem("sidebarCollapsed") === "true"
    this.toggleCollapsed(isCollapsed)
  }

  toggle() {
    const isCurrentlyCollapsed = this.contentTargets.some(target => target.classList.contains(this.itemCollapsedClass))
    this.toggleCollapsed(!isCurrentlyCollapsed)
  }

  toggleCollapsed(collapsed) {
    if (collapsed) {
      this.contentTargets.forEach(target => {
        target.classList.add(this.itemCollapsedClass)
      })
      this.buttonTargets.forEach(target => {
        target.classList.remove(this.buttonExpandedClass)
      })
      this.asideTarget.classList.add(...this.asideCollapsedClasses)
      this.asideTarget.classList.remove(this.asideExpandedClass)
    } else {
      this.contentTargets.forEach(target => {
        target.classList.remove(this.itemCollapsedClass)
      })
      this.buttonTargets.forEach(target => {
        target.classList.add(this.buttonExpandedClass)
      })
      this.asideTarget.classList.remove(...this.asideCollapsedClasses)
      this.asideTarget.classList.add(this.asideExpandedClass)
    }
    // Store state in localStorage
    localStorage.setItem("sidebarCollapsed", collapsed)
  }
}

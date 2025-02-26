import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar"]

  connect() {
    this.sidebarTarget.addEventListener('mouseover', () => {
      this.sidebarTarget.classList.add('expanded')
      localStorage.setItem('sidebarExpanded', 'true')
    })

    this.sidebarTarget.addEventListener('mouseout', () => {
      this.sidebarTarget.classList.remove('expanded')
      localStorage.setItem('sidebarExpanded', 'false')
    })

    // Check if sidebar was expanded before page reload
    if (localStorage.getItem('sidebarExpanded') === 'true') {
      this.sidebarTarget.classList.add('expanded')
    }
  }

  // Prevent sidebar collapse during navigation
  preventCollapse(event) {
    if (this.sidebarTarget.classList.contains('expanded')) {
      localStorage.setItem('sidebarExpanded', 'true')
    }
  }
}
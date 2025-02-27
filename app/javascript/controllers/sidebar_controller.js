import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar"]
  
  connect() {
    this.handleInitialState()
    this.setupEventListeners()
  }

  setupEventListeners() {
    let hoverTimeout

    this.sidebarTarget.addEventListener('mouseenter', () => {
      clearTimeout(hoverTimeout)
      this.expandSidebar()
    })

    this.sidebarTarget.addEventListener('mouseleave', () => {
      if (!this.isNavigating) {
        hoverTimeout = setTimeout(() => {
          this.collapseSidebar()
        }, 100) // Small delay to prevent flickering
      }
    })

    document.addEventListener('turbo:before-visit', () => {
      this.isNavigating = true
      if (this.sidebarTarget.matches(':hover')) {
        this.expandSidebar()
      }
    })

    document.addEventListener('turbo:load', () => {
      this.isNavigating = false
      this.handleInitialState()
    })
  }

  handleInitialState() {
    if (localStorage.getItem('sidebarExpanded') === 'true') {
      requestAnimationFrame(() => {
        this.expandSidebar()
      })
    }
  }

  expandSidebar() {
    this.sidebarTarget.classList.add('expanded')
    localStorage.setItem('sidebarExpanded', 'true')
  }

  collapseSidebar() {
    this.sidebarTarget.classList.remove('expanded')
    localStorage.setItem('sidebarExpanded', 'false')
  }

  preventCollapse(event) {
    // Don't prevent the default behavior, just maintain the state
    if (this.sidebarTarget.matches(':hover')) {
      localStorage.setItem('sidebarExpanded', 'true')
    }
  }
}
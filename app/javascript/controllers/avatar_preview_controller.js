import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview"]

  connect() {
    // If there's no preview target (the avatar image), we don't need to do anything
    if (!this.hasPreviewTarget) return
  }

  // This method is called when the file input changes
  preview() {
    // Get the selected file
    const file = this.inputTarget.files[0]
    if (!file || !file.type.match(/^image\//)) return

    // Create a FileReader to read the image
    const reader = new FileReader()
    
    // Set up the FileReader onload event
    reader.onload = (event) => {
      // Update the preview image with the new image data
      this.previewTarget.src = event.target.result
      
      // Make sure the preview is visible (in case it was showing the placeholder)
      this.previewTarget.classList.remove('hidden')
      
      // If there's a placeholder element, hide it
      const placeholder = this.element.querySelector('.avatar-placeholder')
      if (placeholder) placeholder.classList.add('hidden')
    }
    
    // Read the file as a data URL
    reader.readAsDataURL(file)
  }
}
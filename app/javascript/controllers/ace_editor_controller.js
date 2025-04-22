import { Controller } from "@hotwired/stimulus"
import ace from "ace-builds"
import "ace-builds/src-noconflict/theme-github"
import "ace-builds/src-noconflict/mode-ruby"
import "ace-builds/src-noconflict/mode-json"

export default class extends Controller {
  static targets = ["editor", "input"]
  static values = {
    theme: { type: String, default: "github" },
    mode: { type: String, default: "ruby" },
    content: String
  }

  editor = null

  connect() {
    this.editor = ace.edit(this.editorTarget, {
      theme: `ace/theme/${this.themeValue}`,
      mode: `ace/mode/${this.modeValue}`,
      value: this.inputTarget.value,
      autoScrollEditorIntoView: true,
      copyWithEmptySelection: true,
      tabSize: 2,
      useSoftTabs: true,
      useWorker: false,
    });

    // Ensure the hidden input value updates when the editor changes
    this.editor.session.on("change", () => {
      this.inputTarget.value = this.editor.getValue();
    });
  }

  disconnect() {
    if (this.editor) {
      this.editor.destroy();
      this.editor.container.remove();
    }
  }
}

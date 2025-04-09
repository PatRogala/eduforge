import { Controller } from "@hotwired/stimulus"

import hljs from 'highlight.js/lib/core';
import ruby from 'highlight.js/lib/languages/ruby';
import 'highlight.js/styles/github-dark.css';

// Then register the languages you need
hljs.registerLanguage('ruby', ruby);

// Connects to data-controller="highlight-code-block"
export default class extends Controller {
  connect() {
    this.highlightCode();
  }

  highlightCode() {
    document.querySelectorAll("pre").forEach((block) => {
      hljs.highlightElement(block);
    });
  }
}

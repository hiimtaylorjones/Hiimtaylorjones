import { Controller } from "@hotwired/stimulus"

// GitHub-style Write / Preview tabs for the post body. The preview is rendered
// by the server's markdown helper, so it matches the published post exactly.
export default class extends Controller {
  static targets = ["input", "output", "writeTab", "previewTab"]
  static values = { url: String }

  connect() {
    this.requestId = 0
  }

  write() {
    this.select(this.writeTabTarget)
    this.outputTarget.hidden = true
    this.inputTarget.hidden = false
    this.inputTarget.focus()
  }

  async preview() {
    this.select(this.previewTabTarget)
    // Match the editor's height so switching tabs doesn't make the page jump.
    this.outputTarget.style.minHeight = `${this.inputTarget.offsetHeight}px`
    this.inputTarget.hidden = true
    this.outputTarget.hidden = false

    const body = this.inputTarget.value
    if (body.trim() === "") {
      this.showNote("Nothing to preview.")
      return
    }

    this.showNote("Loading preview…")
    // Tag each request so a slow response can't overwrite a newer one.
    const request = ++this.requestId

    try {
      const response = await fetch(this.urlValue, {
        method: "POST",
        headers: { "X-CSRF-Token": this.csrfToken, "Accept": "text/html" },
        body: new URLSearchParams({ body })
      })
      // An expired session redirects to the sign-in page; don't render that as the preview.
      if (!response.ok || response.redirected) throw new Error(`Preview failed: ${response.status}`)
      const html = await response.text()
      if (request === this.requestId) this.outputTarget.innerHTML = html
    } catch {
      if (request === this.requestId) this.showNote("Preview failed to load. Are you still signed in?")
    }
  }

  select(tab) {
    for (const t of [this.writeTabTarget, this.previewTabTarget]) {
      t.setAttribute("aria-selected", t === tab)
    }
  }

  showNote(text) {
    const note = document.createElement("p")
    note.className = "editor-preview-note"
    note.textContent = text
    this.outputTarget.replaceChildren(note)
  }

  get csrfToken() {
    return document.querySelector('meta[name="csrf-token"]')?.content
  }
}

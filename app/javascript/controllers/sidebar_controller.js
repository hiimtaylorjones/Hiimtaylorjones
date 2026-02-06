import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel"]

  toggle() {
    document.body.classList.toggle("sidebar-open")
  }
}

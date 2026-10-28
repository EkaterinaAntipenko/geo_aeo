import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source"]

  copy(event) {
    navigator.clipboard.writeText(this.sourceTarget.textContent)
    event.currentTarget.classList.add("copied")
    setTimeout(() => event.currentTarget.classList.remove("copied"), 1500)
  }
}

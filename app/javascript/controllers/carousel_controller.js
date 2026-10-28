import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slide"]

  connect() {
    this.index = 0
    this.timer = setInterval(() => this.next(), 7000)
  }

  disconnect() {
    clearInterval(this.timer)
  }

  next() {
    this.show(this.index + 1)
  }

  prev() {
    this.show(this.index - 1)
  }

  show(index) {
    const count = this.slideTargets.length
    if (count === 0) return

    this.index = (index + count) % count
    this.slideTargets.forEach((slide, i) => slide.classList.toggle("active", i === this.index))
  }
}

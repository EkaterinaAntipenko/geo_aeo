import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  scroll(event) {
    if (Math.abs(event.deltaX) > Math.abs(event.deltaY)) return

    const row = this.element
    const max = row.scrollWidth - row.clientWidth
    const atStart = row.scrollLeft <= 0 && event.deltaY < 0
    const atEnd = row.scrollLeft >= max - 1 && event.deltaY > 0
    if (max <= 0 || atStart || atEnd) return

    event.preventDefault()
    row.scrollLeft += event.deltaY
  }
}

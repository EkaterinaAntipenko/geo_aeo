import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  format() {
    let digits = this.element.value.replace(/\D/g, "")
    if (digits.startsWith("8") || digits.startsWith("7")) digits = digits.slice(1)
    digits = digits.slice(0, 10)

    const parts = [digits.slice(0, 3), digits.slice(3, 6), digits.slice(6, 8), digits.slice(8, 10)]
    let result = "+7"
    if (parts[0]) result += ` (${parts[0]}`
    if (parts[1]) result += `) ${parts[1]}`
    if (parts[2]) result += `-${parts[2]}`
    if (parts[3]) result += `-${parts[3]}`

    this.element.value = result
  }
}

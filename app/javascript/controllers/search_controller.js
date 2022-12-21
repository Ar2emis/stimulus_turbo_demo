import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['form', 'input']

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => this.submitForm(), 200)
  }

  submitForm() {
    this.formTarget.requestSubmit()
  }
}

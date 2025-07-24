// app/javascript/controllers/tabs_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel"]
  static values  = { initial: String }

  connect() {
    const start = this.initialValue || this.tabTargets[0].dataset.tabsName
    this.showByName(start)
  }

  show(e) {
    this.showByName(e.currentTarget.dataset.tabsName)
  }

  showByName(name) {
    this.tabTargets.forEach(t => {
      const active = t.dataset.tabsName === name
      t.classList.toggle("border-blue-600", active)
      t.classList.toggle("text-gray-900",  active)
      t.classList.toggle("text-gray-600", !active)
      t.classList.toggle("border-transparent", !active)
      t.classList.toggle("font-semibold", active)
    })

    this.panelTargets.forEach(p => {
      p.classList.toggle("hidden", p.dataset.tabsName !== name)
    })
  }
}
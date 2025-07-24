import { Controller } from "@hotwired/stimulus"

// app/javascript/utils/number_format.js
export function formattedRevenue(number) {
  const abs = Math.abs(number);

  if (abs >= 1_000_000_000) {
    // Billions
    return `${(number / 1_000_000_000).toFixed(2)}B`;
  } else if (abs >= 1_000_000) {
    // Millions
    return `${(number / 1_000_000).toFixed(2)}M`;
  } else {
    // < 1M: comma‐separate with two decimals
    return new Intl.NumberFormat("en-US", {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2
    }).format(number);
  }
}

export default class extends Controller {
  static targets = [
    "container", "row",
    "qty", "price", "lineTotal",
    "subtotal", "tax", "total"
  ]

  connect() {
    this.rowTargets.forEach(r => this.recalcLineFor(r))
    this.recalcAll()
  }

  add(e) {
    e.preventDefault()
    const tmpl = document.querySelector("#item-template").content.cloneNode(true)
    const newIndex = Date.now()

    tmpl.querySelectorAll("[name]").forEach(el => {
      el.name = el.name.replace(/NEW_RECORD/g, newIndex)
      if (el.id) el.id = el.id.replace(/NEW_RECORD/g, newIndex)
    })

    this.containerTarget.appendChild(tmpl)
    this.recalcAll()
  }

  remove(e) {
    e.preventDefault()
    const row = e.target.closest(".item-row")
    const destroyInput = row.querySelector('input[name*="_destroy"]')
    if (destroyInput) { destroyInput.value = "1"; row.style.display = "none" }
    else { row.remove() }
    this.recalcAll()
  }

  setPrice(e) {
    const select = e.currentTarget
    const row = select.closest(".item-row")
    const priceInput = row.querySelector('[data-item-row-target="price"]')
    const price = select.selectedOptions[0]?.dataset.price
    if (price && priceInput) priceInput.value = Number(price).toFixed(2)
    this.recalcLineFor(row)
    this.recalcAll()
  }

  recalcLine(e) {
    const row = e.currentTarget.closest(".item-row")
    this.recalcLineFor(row)
    this.recalcAll()
  }

  recalcLineFor(row) {
    const qty   = parseFloat(row.querySelector('[data-item-row-target="qty"]').value)   || 0
    const price = parseFloat(row.querySelector('[data-item-row-target="price"]').value) || 0
    const total = qty * price
    const span  = row.querySelector('[data-item-row-target="lineTotal"]')
    if (span) span.textContent = total.toFixed(2)
  }

  recalcAll() {
    const rows = this.rowTargets.filter(r => r.style.display !== "none")
    let subtotal = 0
    rows.forEach(r => {
      const qty   = parseFloat(r.querySelector('[data-item-row-target="qty"]').value)   || 0
      const price = parseFloat(r.querySelector('[data-item-row-target="price"]').value) || 0
      subtotal += qty * price
    })
    const tax   = subtotal * 0.10
    const total = subtotal + tax

    if (this.hasSubtotalTarget) this.subtotalTarget.textContent = formattedRevenue(subtotal.toFixed(2))
    if (this.hasTaxTarget)      this.taxTarget.textContent      = formattedRevenue(tax.toFixed(2))
    if (this.hasTotalTarget)    this.totalTarget.textContent    = formattedRevenue(total.toFixed(2))
  }
}
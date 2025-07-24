# Restaurant Manager

A simple Ruby on Rails application to manage Restaurants, Dishes and Orders, built with Tailwind CSS, Stimulus, and Active Storage for image uploads.

## 🚀 Features

- **Restaurants**  
  - Create, view, edit, delete restaurants  
  - Upload and display a restaurant logo/image via Active Storage  
- **Dishes**  
  - Nest dishes under restaurants  
  - Create, view, edit, delete dishes  
  - Upload and display dish photos via Active Storage  
  - Grouped into “Entrees”, “Soups & Salads”, “Desserts”, “Drinks”  
- **Orders & Items**  
  - Place orders for a given restaurant  
  - Add line‐items (dishes + quantity), automatically snapshotting the dish price  
  - Dynamically calculate & format Subtotal, Tax (10%), and Total with commas & K/M/B suffixes  
- **UI**  
  - Tailwind CSS for mobile‐friendly, utility-first styling  
  - Stimulus controllers for live recalculation of order totals  
  - Line-clamped descriptions with ellipses  

## 🛠️ Technology Stack

- Ruby 3.2+ / Rails 7.0+  
- PostgreSQL (or SQLite for quick dev)  
- Tailwind CSS (+ `@tailwindcss/line-clamp`)  
- Stimulus Reflex / Hotwire (Turbo + Stimulus)  
- Active Storage (local disk in development)  
- Faker & FactoryBot for seeds & factories  

## 📋 Prerequisites

- Ruby ≥ 3.0  
- Rails ≥ 7.0  
- PostgreSQL (or SQLite)  
- Node.js & Yarn (for Webpacker/Tailwind)  
- Git

## 🔧 Installation

1. **Clone the repo**  
   ```bash
   git clone git@github.com:sntggrz/restaurant-manager.git
   cd restaurant-manager
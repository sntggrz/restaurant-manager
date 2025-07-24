module ApplicationHelper
  def nav_link_to(name, path, opts = {})
    active_classes = "font-semibold text-blue-600"
    inactive_classes = "text-gray-600"
    base_classes = "hover:underline"

    klass = [ base_classes,
             current_page?(path) ? active_classes : inactive_classes,
             opts[:class] ].compact.join(" ")

    link_to name, path, opts.merge(class: klass)
  end

  def dish_options(restaurant)
    restaurant.dishes.map { |d| [ d.name, d.id, { 'data-price': d.price } ] }
  end

  def formatted_revenue(number)
    abs = number.abs

    formatted =
      if abs >= 1_000_000_000
        # Billions
        "#{sprintf('%.2f', number / 1_000_000_000.0)}B"
      elsif abs >= 1_000_000
        # Millions
        "#{sprintf('%.2f', number / 1_000_000.0)}M"
      else
        # Below 1M: just comma‐separate thousands, show two decimals
        number_with_precision(number, precision: 2, delimiter: ",", separator: ".")
      end

    # Re-add sign if negative
    number.negative? ? "-#{formatted}" : formatted
  end
end

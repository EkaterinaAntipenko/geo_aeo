module DashboardHelper
  MONTHS = %w[Янв Фев Мар Апр Май Июн Июл Авг Сен Окт Ноя Дек]

  def month_name(date)
    MONTHS[date.month - 1]
  end

  def chart_max(values)
    max = [ values.max.to_i, 4 ].max
    step = 10**(max.to_s.length - 1)
    (max.to_f / step).ceil * step
  end

  def chart_points(values, width, height)
    max = chart_max(values)
    step = values.size > 1 ? width.to_f / (values.size - 1) : 0
    values.each_with_index.map { |value, i| [ (i * step).round(1), (height - value.to_f / max * height).round(1) ] }
  end

  def chart_path(points)
    return "" if points.empty?

    path = "M#{points[0][0]},#{points[0][1]}"
    points.each_cons(2) do |(x1, y1), (x2, y2)|
      middle = ((x1 + x2) / 2).round(1)
      path += " C#{middle},#{y1} #{middle},#{y2} #{x2},#{y2}"
    end
    path
  end
end

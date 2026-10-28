module ApplicationHelper
  def nav_item(title, icon, path, active: false)
    link_to path, class: class_names("nav-item", active: active) do
      image_tag("okula/#{icon}", alt: "", class: "nav-icon") + tag.span(title)
    end
  end

  def breadcrumbs(*items)
    content_for :breadcrumbs do
      parts = [ link_to("Главная", root_path, class: "crumb-root") ]
      items.each_with_index do |(title, path), i|
        parts << tag.span(">", class: "crumb-sep")
        parts << (path && i < items.size - 1 ? link_to(title, path, class: "crumb-link") : tag.span(title, class: "crumb-current"))
      end
      safe_join(parts)
    end
  end

  def user_avatar(user, size: "md")
    if user.avatar.present?
      image_tag(user.avatar, alt: user.name, class: "avatar avatar-#{size}")
    else
      tag.span(user.initials, class: "avatar avatar-#{size} avatar-empty")
    end
  end

  def priority_bars(priority)
    tag.span(class: "priority") do
      safe_join(Array.new(priority) { tag.i })
    end
  end

  def rubles(amount)
    "#{number_with_delimiter(amount, delimiter: ' ')} ₽"
  end
end

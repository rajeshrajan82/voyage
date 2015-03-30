module ApplicationHelper
  def icon_text(text, icon)
    return ('<i class="'+ icon + '"></i> ' + text).html_safe
  end

  def show_icon(icon)
    return ('<i class="'+ icon + '"></i>').html_safe
  end
end

module ApplicationHelper

  def urls_to_images(s)
    s.gsub!(/(http.*?\.(png|jpg))/, '<p><img width="90px" height="70px" src="\1"></p>')
    s.html_safe
  end

  def urls_to_links(s)
    s = s << ' '
    s.gsub!(/\s(http.*?)\s/, '<a href="\1"/>\1</a>')
    s.html_safe
  end

end

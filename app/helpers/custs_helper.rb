module CustsHelper
  def service_span(cust,service)
    # <span class="label label-success">沪A</span>.html_safe
    case service
    when "1"
      if cust.ha
        content_tag(:span, "沪A", :class => "label label-success")
      else
        content_tag(:span, "沪A", :class => "label")
      end
    when "2"
      if cust.sa
        content_tag(:span, "深A", :class => "label label-success")
      else
        content_tag(:span, "深A", :class => "label")
      end
    when "3"
      if cust.hb
        content_tag(:span, "沪B", :class => "label label-success")
      else
        content_tag(:span, "沪B", :class => "label")
      end
    when "4"
      if cust.sb
        content_tag(:span, "深B", :class => "label label-success")
      else
        content_tag(:span, "深B", :class => "label")
      end
    when "H"
      if cust.hg
        content_tag(:span, "沪港通", :class => "label label-success")
      else
        content_tag(:span, "沪港通", :class => "label")
      end
    when "O"
      if cust.otc
        content_tag(:span, "OTC", :class => "label label-success")
      else
        content_tag(:span, "OTC", :class => "label")
      end
    when "w"
      if cust.wx
        content_tag(:span, "微信", :class => "label label-success")
      else
        content_tag(:span, "微信", :class => "label")
      end
    when "R"
      if cust.rzrq
        content_tag(:span, "融资融券", :class => "label label-success")
      else
        content_tag(:span, "融资融券", :class => "label")
      end
    when "J"
      if cust.cyb
        content_tag(:span, "创业板", :class => "label label-success")
      else
        content_tag(:span, "创业板", :class => "label")
      end
    end

  end
end

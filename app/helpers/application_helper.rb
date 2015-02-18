module ApplicationHelper

  def display_errors(obj)
    Waggle::ErrorMessages.new(obj).display_error
  end

  def exhibit_nav(exhibit, active)
    Waggle::SideNav.new(exhibit).display(active)
  end

  def showcase_title(showcase)
    page_title(showcase.exhibit.title, showcase.title, exhibit_showcases_path(showcase.exhibit))
  end

  def exhibit_title(exhibit, sub_title = "")
    page_title(exhibit.title, sub_title, exhibit_showcases_path(exhibit))
  end

  def page_title(title, small_title = "", link_href = "")
    content_for(:page_title) do
      Waggle::PageTitle.new(title).display do | pt |
        pt.small_title = small_title
        pt.link_href = link_href
      end
    end
  end
end

module ApplicationHelper

  def display_errors(obj)
    Waggle::ErrorMessages.new(obj).display_error
  end

  def exhibit_nav(exhibit, active)
    Waggle::SideNav.new(exhibit).display(active)
  end

  def showcase_title(showcase)
    right_content = link_to(raw('<i class="glyphicon glyphicon-cog"></i> Settings'), edit_exhibit_path(showcase.exhibit), class: 'btn btn-sm', role: 'button')
    page_title(showcase.exhibit.title, showcase.title, exhibit_path(showcase.exhibit), right_content)
  end

  def exhibit_title(exhibit, sub_title = "")
    right_content = link_to(raw('<i class="glyphicon glyphicon-cog"></i> Settings'), edit_exhibit_path(exhibit), class: 'btn btn-sm', role: 'button')
    page_title(exhibit.title, sub_title, exhibit_showcases_path(exhibit), right_content)
  end

  def page_title(title, small_title = "", link_href = "", right_content="")
    content_for(:page_title) do
      Waggle::PageTitle.new(title).display do | pt |
        pt.small_title = small_title
        pt.link_href = link_href
        pt.right_content = right_content
      end
    end
  end
end

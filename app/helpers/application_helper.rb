module ApplicationHelper
  # Returns the full tile of the page
  def title(page_title = "")
    base_title = "KC Sheng's Sample App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
end

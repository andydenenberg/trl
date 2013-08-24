module PostsHelper
  
  def type_color(type_is)
    color = 'label'
    if type_is == 'News'
      color = 'label label-info'
    elsif type_is == 'Discussion'
      color = 'label'
    end  
    return color
  end  
  
end

def categories 
    [
          '100 SERIES - GENERAL', '200 SERIES - APPLICATION & INSTALLATION',
          '300 SERIES - TESTING', '400 SERIES - CERTFICATIONS & APPROVALS',
          '500 SERIES - PRODUCT COMPARISONS', '600 SERIES - ARTICLES & WHITE PAPERS' ]
end
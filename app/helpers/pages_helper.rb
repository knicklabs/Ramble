# Helper methods defined here can be accessed in any controller or view in the application
Ramble.helpers do
  def fetch_page(id)
    directories = Dir.glob("content/pages/#{id.downcase}").select { |f| File.directory? f }
    pages = []
    
    directories.to_a.each do |directory|
      pages.push Page.new({directory: directory})
    end
    
    pages[0] || nil
  end
  
  def fetch_pages()
    directories = Dir.glob("content/pages/*").select { |f| File.directory? f }
    pages = []
    
    directories.to_a.each do |directory|
      pages.push Page.new({directory: directory})
    end
    
    pages
  end
  
  def navigation
    pages = fetch_pages
    
    html  =  '<nav>'
    html  << '<ul class="nav">'
    pages.each do |page|
      html << '<li>'
      html << '<a href="' << url_for(:pages, :index, id: page.filename) << '">' << page.menu_title << '</a>'
      html << '</li>'  
    end
    html << '</ul>'
    html << '</nav>'
  end
end
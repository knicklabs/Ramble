class Ramble < Padrino::Application
  register SassInitializer
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers

  enable :sessions
  
  before do
    @settings = YAML::load(File.read('config/settings.yml'))
  end
  
  get :index do
    home = @settings["homepage"]
    
    if home.downcase == "blog"
      redirect url(:posts, :index)
    else
      directories = Dir.glob("content/pages/#{home}").select { |f| File.directory? f }
      pages = []
      
      directories.to_a.each do |directory|
        pages.push Page.new({directory: directory})
      end
      
      @page = pages[0] || nil
      
      render 'pages/show', layout: @page.setting_for(:layout) || "application"
    end
  end
  
  get :index, with: :title do
    directories = Dir.glob("content/pages/#{params[:title].downcase}").select { |f| File.directory? f }
    pages = []
    
    directories.to_a.each do |directory|
      pages.push Page.new({directory: directory})
    end
    
    @page = pages[0] || nil
    
    render 'pages/show', layout: @page.setting_for(:layout) || "application"
  end
end
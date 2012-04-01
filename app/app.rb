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
      @page = fetch_page(home)
      
      view = "packages/" << @settings["package"] << "/pages/show"
      layout = "packages/" << @settings["package"] << "/layouts/" << (@page.setting_for("layout") || "application")
      
      render view, layout: layout
    end
  end
end
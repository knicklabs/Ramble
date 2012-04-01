Ramble.controllers :pages do
  before do
    @settings = YAML::load(File.read('config/settings.yml'))
  end
  
  get :index, with: :id do
    @page = fetch_page(params[:id]) 
    
    view   = "packages/" << @settings["package"] << "/pages/show"
    layout = "packages/" << @settings["package"] << "/layouts/" << (@page.setting_for("layout") || "application")  
      
    render view, layout: layout
  end
end
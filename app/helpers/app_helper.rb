Ramble.helpers do
  def get_settings
    YAML::load(File.read('config/settings.yml'))
  end
  
  def pkg_path
    "packages/#{get_settings["package"]}"
  end
  
  def site_title
    "#{get_settings["site"]["title"]}"
  end
end
module SettingsHelper
  class Settings
    def self.fetch
      YAML::load(File.read('config/settings.yml'))
    end
  end
end
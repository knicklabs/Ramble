require 'kramdown'

class Page
  attr_accessor :directory, :filename, :title, :menu_title
  
  def initialize(options = {})
    @directory = options[:directory] unless options[:directory].blank?
    @settings = YAML::load(File.read("#{@directory}/settings.yml"))
    @title = setting_for(:title) || @directory.humanize
    @filename = File.basename(@directory)
    @menu_title = setting_for(:menu_title) || setting_for(:title) || @filename.humanize
  end
  
  def setting_for(key)
    @settings[key.to_s] || nil
  end
  
  def content_for(key)
    content  = ""
    filename = "#{@directory}/#{key.to_s}.txt"
    if File.exists? filename
      file = File.open(filename)
      file.each { |line| content << line }
      file.close unless file.closed?
    end
    Kramdown::Document.new(content).to_html
  end
end
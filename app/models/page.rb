require 'kramdown'

class Page
  attr_accessor :directory, :title
  
  def initialize(options = {})
    @directory = options[:directory] unless options[:directory].blank?
    @settings = YAML::load(File.read("#{@directory}/settings.yml"))
  end
  
  def setting_for(key)
    @settings[key.to_s] || nil
  end
  
  def content_for(key)
    file = File.open("#{@directory}/#{key.to_s}.txt")
    content = ""
    file.each { |line| content << line }
    file.close unless file.closed?
    
    Kramdown::Document.new(content).to_html
  end
end
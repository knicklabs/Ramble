require 'kramdown'

class Post
  attr_accessor :file, :title, :created_at
  
  def initialize(options = {})
    @file = options[:file] unless options[:file].blank?
    hydrate
  end
  
  def content
    # We load the content and only when it is requested.
    file = File.open(@file)
    content = ""
    file.each { |line| content << line }
    file.close unless file.closed?
    
    Kramdown::Document.new(content).to_html
  end
  
  private
  
  def hydrate
    basename = File.basename(@file)
    
    @title = (basename.split("_")[1]).gsub('-', ' ').sub('.txt', '')
    @created_at = basename.split("_")[0]
  end
end
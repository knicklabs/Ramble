# Posts
#
# The posts controller includes logic for displaying 
# posts and lists of posts.

Ramble.controllers :posts do
  before do
    @settings = YAML::load(File.read('config/settings.yml'))
  end
  
  # Index reads all blog posts from disk.
  get :index, map: "blog" do
    files = Dir.glob("content/posts/*.txt")
    @posts = []
    
    files.to_a.each do |file|
      @posts.push Post.new({file: file})
    end
    
    render 'posts/index'
  end
  
  # Reads a single blog post from disk.
  get :blog, map: "blog", with: [:date, :title] do
    files = Dir.glob("content/posts/#{params[:date]}_#{params[:title]}.txt")
    posts = []
    
    files.to_a.each do |file|
      posts.push Post.new({file: file})
    end

    @post = posts[0] || nil
    
    render 'posts/show'
  end  
end

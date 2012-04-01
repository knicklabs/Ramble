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
    @posts = fetch_posts
    
    render 'posts/index'
  end
  
  # Reads a single blog post from disk.
  get :blog, map: "blog", with: [:date, :title] do
    @post = fetch_post(params[:date].downcase, params[:title].downcase)
    
    render 'posts/show'
  end  
end

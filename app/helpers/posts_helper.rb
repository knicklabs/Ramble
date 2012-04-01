# Helper methods defined here can be accessed in any controller or view in the application

Ramble.helpers do
  def fetch_posts()
    files = Dir.glob("content/posts/*.txt")
    posts = []
    
    files.to_a.each do |file|
      posts.push Post.new({file: file})
    end
    
    posts
  end
  
  def fetch_post(date, title)
    files = Dir.glob("content/posts/#{params[:date]}_#{params[:title]}.txt")
    posts = []
    
    files.to_a.each do |file|
      posts.push Post.new({file: file})
    end
    
    posts[0] || nil
  end
end
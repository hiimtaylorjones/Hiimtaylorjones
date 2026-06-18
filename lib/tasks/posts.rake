namespace :posts do
  desc "Export all post bodies from database to db/posts/<slug>.md files"
  task export_to_files: :environment do
    dir = Rails.root.join("db", "posts")
    FileUtils.mkdir_p(dir)
    Post.where.not(body: [nil, ""]).find_each do |post|
      next if post.slug.blank?
      path = dir.join("#{post.slug}.md")
      if File.exist?(path)
        puts "SKIP #{post.slug} (file already exists)"
      else
        File.write(path, post[:body])
        puts "EXPORTED #{post.slug} -> db/posts/#{post.slug}.md"
      end
    end
    puts "Done. #{Post.count} posts processed."
  end
end

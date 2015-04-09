# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.muselyrics.com"
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(
aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
fog_provider: 'AWS',
fog_directory: ENV['AWS_BUCKET']
)
SitemapGenerator::Sitemap.sitemaps_host = ENV['SITEMAP_HOST']
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #

  add '/contact'
  add '/about'

  Album.all.each do |album|
    add album_path(album), :lastmod => album.updated_at
  end

  Song.all.each do |song|
    add album_song_path(song.album, song), :lastmod => song.updated_at
  end
end

require 'slack-ruby-bot'
require 'uri'
require 'link_thumbnailer'
require 'dotenv'
Dotenv.load!

module Slumberlog
  class Bot < SlackRubyBot::Bot
    include SlackRubyBot::Loggable

    URI_RE = URI.regexp(['http', 'https'])

    scan(URI_RE) do |_client, data, _url|
      logger.warn data.inspect
      URI.extract(data.text).each do |uri|
        link = Link.new(url: uri)
        link.date    = Time.now
        link.channel = data.channel
        link.user    = data.user

        begin
          metadata = LinkThumbnailer.generate(uri)
          link.title       = metadata.title
          link.image_url   = metadata.images.first.src if metadata.images.first
          link.description = metadata.description
        rescue LinkThumbnailer::Exceptions => e
          logger.error e
        end

        link.save
      end
    end
  end
end

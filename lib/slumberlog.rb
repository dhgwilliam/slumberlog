require 'ohm'
Ohm.redis = Redic.new('redis://127.0.0.1:6379')

require 'slumberlog/slackbot'
require 'slumberlog/link'

SlackRubyBot::Client.logger.level = Logger::WARN
Slumberlog::Bot.run

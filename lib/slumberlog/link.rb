module Slumberlog
  class Link < Ohm::Model
    attribute :title
    attribute :url
    attribute :date
    attribute :channel
    attribute :user
    attribute :image_url
    attribute :description
  end
end

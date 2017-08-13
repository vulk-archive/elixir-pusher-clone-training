require "net/http"
require "uri"
class PusherEvent
  include ActiveModel::Model

  attr_accessor :name, :message, :broadcast
  validates :name, :message, presence: true

  def save
    topic = Rails.application.secrets.pusher_channel

    uri = PusherLite.uri
    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Post.new uri
      request.add_field('Content-Type', 'application/json')
      request.body = {
        "topic" => topic,
        "event" => "msg",
        "scope" => "public",
        "payload" => {"name" => name, "message" => message}.to_json}.to_json
      http.request request
    end
  end

end

require "net/http"
require "uri"
class PusherEvent
  include ActiveModel::Model

  attr_accessor :name, :message, :broadcast
  validates :name, :message, presence: true

  def jwt(token)
    JWT.encode(jwt_claims(token), Rails.application.secrets.pusher_secret, 'HS256')
  end

  def jwt_claims(token)
    {
      iss: "ExPusherLite",
    }
  end

  def save
    topic = Rails.application.secrets.pusher_channel

    encoded_token = Base64.urlsafe_encode64(SecureRandom.random_bytes(32))

    token = jwt(encoded_token)

    uri = PusherLite.uri
    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Post.new uri
      request.add_field('Content-Type', 'application/json')
      ###
      request.add_field("Authorization", "Bearer #{token}")
      ###
      request.body = {
        "topic" => topic,
        "event" => "msg",
        "scope" => "public",
        "payload" => {"name" => name, "message" => message}.to_json}.to_json
      http.request request
    end
  end

end

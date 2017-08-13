module PusherLite
  def self.uri
    url    = Rails.application.secrets.pusher_url

    uri = URI::encode("http://#{url}/events")
    URI.parse(uri)
  end
end

class PusherEvent
  include ActiveModel::Model

  attr_accessor :name, :message, :broadcast
  validates :name, :message, presence: true

end

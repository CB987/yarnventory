class CeparFeedChannel < ApplicationCable::Channel
  def subscribed
    stream_from "cepar_feed_channel"
  end

  def talk(data)
    message = data["content"]
    ActionCable.server.broadcast("cepar_feed_channel", { content: message })
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

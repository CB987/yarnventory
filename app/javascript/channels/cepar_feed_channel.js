import consumer from "channels/consumer"

const ceparFeedChannel = consumer.subscriptions.create("CeparFeedChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to CeparFeedChannel.");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("Disconnected from CeparFeedChannel.");
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const messagesDiv = document.getElementById("messages");
    if (messagesDiv && data.content) {
      const messageElement = document.createElement("p");
      messageElement.textContent = data.content;
      messagesDiv.appendChild(messageElement);
    }
  }
});


function sendMessage(content) {
  ceparFeedChannel.perform("talk", { content: content });
}

export { sendMessage };
window.sendMessage = sendMessage;
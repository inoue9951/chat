App.chat_room = App.cable.subscriptions.create("ChatRoomChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    console.log(data);
    let chatArea = document.getElementById('chat-area');
    let div = document.createElement('div');
    let name = document.createElement('h6');
    let message = document.createElement('p');
    let hr = document.createElement('hr');
    name.textContent = data['data']['name'];
    message.textContent = data['data']['message'];
    div.appendChild(name);
    div.appendChild(message);
    div.appendChild(hr);
    chatArea.appendChild(div);
  },

  speak: function(message, id) {
    console.log('speak')
    return this.perform('speak', { message: message, id: id });
  }
});

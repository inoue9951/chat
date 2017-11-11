// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

window.onload = function() {
  let btn = document.getElementById('send-btn');
  btn.addEventListener('click', function() {
    let textarea = document.getElementById('message-form');
    let userId = document.getElementById('user-id');
    console.log(userId.value);
    App.chat_room.speak(textarea.value, userId.value);
    textarea.value = '';
  });
}

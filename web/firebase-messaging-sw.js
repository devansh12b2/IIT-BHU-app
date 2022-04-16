importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js");
firebase.initializeApp({
    apiKey: "AIzaSyBFJg5PPHJKrW8F3OTG6-ZjgbaISkBqI7Q",
    authDomain: "iit-bhu-workshops-app.firebaseapp.com",
    databaseURL: "https://iit-bhu-workshops-app.firebaseio.com",
    projectId: "iit-bhu-workshops-app",
    storageBucket: "iit-bhu-workshops-app.appspot.com",
    messagingSenderId: "897714770024",
    appId: "1:897714770024:web:a29b87b28239e2a227abdd",
    measurementId: "G-7FLHSBVJS2"
});
const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});

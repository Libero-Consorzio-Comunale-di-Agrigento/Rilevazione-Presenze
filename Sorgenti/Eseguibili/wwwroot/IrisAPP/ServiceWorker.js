console.log('Started SW', self);

self.addEventListener('install', function(event) 
{
  self.skipWaiting();
  console.log('Installed SW', event);
});

self.addEventListener('activate', function(event) 
{
  console.log('Activated SW', event);
});

self.addEventListener('fetch', function(event) 
{
  console.log('SW Fetching');
});

self.addEventListener('push', function(e) 
{
  var data = e.data.json();
  
  var options = 
  {
    body: data.body,
    icon: 'wwwroot/IrisAPP/favicon/android-icon-96x96.png',
    vibrate: [200, 100, 200],
    data: 
	{
      dateOfArrival: Date.now(),
      primaryKey: data.id					//possibile id della notifica
    },
    actions: 
	[
      {
		  action: 'explore', 
		  title: 'Apri IrisAPP',
          icon: 'wwwroot/IrisAPP/img/check.png'
	  },
      {
		  action: 'close', 
		  title: 'Chiudi',
          icon: 'wwwroot/IrisAPP/img/cross.png'
	  }
    ]
  };
  
  e.waitUntil(self.registration.showNotification(data.title, options));
});

self.addEventListener('notificationclose', function(e) 
{
  var notification = e.notification;
  var primaryKey = notification.data.primaryKey; //passato nelle options

  console.log('Closed notification: ' + primaryKey);
});

self.addEventListener('notificationclick', function(e) 
{
  var notification = e.notification;
  var primaryKey = notification.data.primaryKey;
  var action = e.action;

  if (action === 'close') 
  {
    notification.close();
  } 
  else 
  {
    clients.openWindow('WM000PIrisAPP.dll');
    notification.close();
  }
});







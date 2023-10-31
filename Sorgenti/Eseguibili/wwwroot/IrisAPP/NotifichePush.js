
  //funzioni di utili
  function urlBase64ToUint8Array(base64String) 
  {
     var padding = '='.repeat((4 - base64String.length % 4) % 4);
     var base64 = (base64String + padding)
        .replace(/\-/g, '+')
        .replace(/_/g, '/');
         
     var rawData = window.atob(base64);
     var outputArray = new Uint8Array(rawData.length);

     for (var i = 0; i < rawData.length; ++i) 
     {
         outputArray[i] = rawData.charCodeAt(i);
     };
     return outputArray;
  }
   
  function _arrayBufferToBase64(buffer) 
  {
     var binary = '';
     var bytes = new Uint8Array(buffer);
     var len = bytes.byteLength;
     for (var i = 0; i < len; i++) 
     {
        binary += String.fromCharCode(bytes[i]);
     };
     return window.btoa(binary);
  }
  
  
  function registrazioneNotifichePush(urlServiceWorker)   //"/IrisAPP/ServiceWorker.js"
  {
      //registrazione
      if ('serviceWorker' in navigator) 
      {
         if ('PushManager' in window) 
         {
            navigator.serviceWorker.register(urlServiceWorker).then(function(registration) 
            {
               console.log("Notifiche: registrazione service worker riuscita");
           
            }).catch(function(err) 
            {
               console.error("Notifiche: errore nella registrazione del service worker", err);
            })
         } 
         else 
         {
            console.warn("Notifiche: PushManager non supportato");
         }
      } 
      else 
      {
         console.warn("Notifiche: ServiceWorker non supportato");
      }
  }
  
  //inviaDatiAlServer -> funzione che riceve come parametro url, p256dh (base64) e auth (base64) da inviare al server
  function iscrizioneNotifichePush(applicationServerKey, inviaDatiAlServer) //"BPHkCt-By5ue1HIRUa2EuuBzM_9oYLDNZTae5JIn2EcKfGXYc_zzQNQa6F4xBPt6TrpFJCMcFA9CO9ZWv3Hx0J8"
  {
      //iscrizione con richiesta all'utente 
      navigator.serviceWorker.ready.then(function(registration) 
      {
         registration.pushManager.subscribe(
         {
	        userVisibleOnly: true,
	        applicationServerKey: urlBase64ToUint8Array(applicationServerKey)
         })
         .then(function(subscription) 
         {
	        console.log("Notifiche: iscrizione riuscita");
            //Passo i dati al server
			inviaDatiAlServer(subscription.endpoint, _arrayBufferToBase64(subscription.getKey("p256dh")), _arrayBufferToBase64(subscription.getKey("auth")));
        })
         .catch(function(err) 
         {
            if (Notification.permission === 'denied') 
	        {
	        	console.warn("Notifiche: permesso negato");
	        } 
	        else 
	        {
		      console.error("Notifiche: errore nell'iscrizione", err);
	        }
         })
      })
  }
  
   function inviaDatiAIrisAPP(url, p256dh, auth)
   {			
      ajaxRequest(WM000FTestFM.MedpUnimEdit1, "pushSubscribe", ["url=" + url, "p256dh=" + p256dh, "auth=" + auth]);		  
   }
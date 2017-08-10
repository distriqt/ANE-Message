
## Sending an SMS with UI

The example below shows how to send an SMS using the native UI:

```as3
if (Message.service.smsManager.isSMSSupported)
{
	Message.service.smsManager.addEventListener( MessageSMSEvent.MESSAGE_SMS_CANCELLED, smsEventHandler );
	Message.service.smsManager.addEventListener( MessageSMSEvent.MESSAGE_SMS_SENT, smsEventHandler );
	Message.service.smsManager.addEventListener( MessageSMSEvent.MESSAGE_SMS_SENT_ERROR, smsEventHandler );
					
	var sms:SMS = new SMS();
	sms.address = "0444444444";
	sms.message = "Sending an SMS with the distriqt Message ANE";
	
	Message.service.smsManager.sendSMSWithUI( sms, false );
}

...

private function smsEventHandler( event:MessageSMSEvent ):void
{
	trace( event.type +"::"+ event.details + "::"+event.sms.toString() );
}
```



## Sending an SMS directly

On Android you can request permission to directly send and receive SMS messages without 
user interaction. 


### Requesting Authorisation

Firstly you must request authorisation to send and receive messages. 

On Android these permissions are listed through the manifest additions. 
On older versions of Android these permissions are accepted when the user installs the application. 
More modern versions (Marshmallow 6 [v23]+) require that you request the permissions similar to iOS. 
You will still need to list them in your manifest and then follow the same code below as for iOS, except that on Android you will be able to ask multiple times. 
You should respect the `SHOULD_EXPLAIN` status by displaying additional information to your user about why you require this functionality.

The following code will work across both platforms:


```as3
Message.service.smsManager.addEventListener( AuthorisationEvent.CHANGED, authorisationStatus_changedHandler );

switch (Message.service.smsManager.authorisationStatus())
{
	case AuthorisationStatus.SHOULD_EXPLAIN:
	case AuthorisationStatus.NOT_DETERMINED:
		// REQUEST ACCESS: This will display the permission dialog
		Message.service.smsManager.requestAuthorisation();
		return;
	
	case AuthorisationStatus.DENIED:
	case AuthorisationStatus.UNKNOWN:
	case AuthorisationStatus.RESTRICTED:
		// ACCESS DENIED: You should inform your user appropriately
		return;
		
	case AuthorisationStatus.AUTHORISED:
		// AUTHORISED: SMS will be available
		break;						
}
```

```as3
private function authorisationStatus_changedHandler( event:AuthorisationEvent ):void
{
	trace( "authorisationStatus_changedHandler: "+event.status );
}
```


### Sending an SMS

Once you have authorisation, sending an SMS is a simple matter of calling `sendSMS`:


```as3
if (Message.service.smsManager.isSMSSupported)
{
	var sms:SMS = new SMS();
	sms.address = "0444444444";
	sms.message = "Testing Message ANE";
	
	Message.service.smsManager.sendSMS( sms );
}
```


### Events

You can listen for several events, as defined in the `MessageSMSEvent` class, see the documentation
in that class for more information on the events.

```as3
Message.service.smsManager.addEventListener( MessageSMSEvent.MESSAGE_SMS_CANCELLED, 	message_smsEventHandler );
Message.service.smsManager.addEventListener( MessageSMSEvent.MESSAGE_SMS_DELIVERED, 	message_smsEventHandler );
Message.service.smsManager.addEventListener( MessageSMSEvent.MESSAGE_SMS_RECEIVED, 		message_smsEventHandler );
Message.service.smsManager.addEventListener( MessageSMSEvent.MESSAGE_SMS_SENT, 			message_smsEventHandler );
Message.service.smsManager.addEventListener( MessageSMSEvent.MESSAGE_SMS_SENT_ERROR, 	message_smsEventHandler );
```

```as3
private function message_smsEventHandler( event:MessageSMSEvent ):void
{
	trace( event.type +"::"+ event.details + "::"+event.sms.toString() );
}
```

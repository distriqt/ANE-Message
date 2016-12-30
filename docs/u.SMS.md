
## Sending an SMS

The example below shows how to send an SMS using the native UI:

```as3
if (Message.isSMSSupported)
{
	Message.service.addEventListener( MessageSMSEvent.MESSAGE_SMS_CANCELLED, smsEventHandler );
	Message.service.addEventListener( MessageSMSEvent.MESSAGE_SMS_SENT, smsEventHandler );
	Message.service.addEventListener( MessageSMSEvent.MESSAGE_SMS_SENT_ERROR, smsEventHandler );
					
	var sms:SMS = new SMS();
	sms.address = "0444444444";
	sms.message = "Sending an SMS with the distriqt Message ANE";
	
	Message.service.sendSMSWithUI( sms, false );
}

...

private function smsEventHandler( event:MessageSMSEvent ):void
{
	trace( event.type +"::"+ event.details + "::"+event.sms.toString() );
}
```
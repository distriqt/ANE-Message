/**
 *        __       __               __ 
 *   ____/ /_ ____/ /______ _ ___  / /_
 *  / __  / / ___/ __/ ___/ / __ `/ __/
 * / /_/ / (__  ) / / /  / / /_/ / / 
 * \__,_/_/____/_/ /_/  /_/\__, /_/ 
 *                           / / 
 *                           \/ 
 * http://distriqt.com
 *
 * @file   		MessageHelper.as
 * @created		28/05/2016
 */
package com.distriqt.test.message
{
	import com.adobe.images.JPGEncoder;
	import com.distriqt.extension.message.AuthorisationStatus;
	import com.distriqt.extension.message.Message;
	import com.distriqt.extension.message.MessageAttachment;
	import com.distriqt.extension.message.events.AuthorisationEvent;
	import com.distriqt.extension.message.events.MessageEvent;
	import com.distriqt.extension.message.events.MessageSMSEvent;
	import com.distriqt.extension.message.events.ShareEvent;
	import com.distriqt.extension.message.objects.SMS;
	
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.media.CameraUI;
	import flash.utils.ByteArray;
	
	import starling.display.Sprite;
	
	
	/**
	 */
	public class MessageTests extends Sprite
	{
		
		[Embed("/image.png")]
		public var Image:Class;
		
		public static const TAG:String = "";
		
		private var _l:ILogger;
		
		
		private function log( log:String ):void
		{
			_l.log( TAG, log );
		}
		
		
		private var textfileNativePath:String;
		private var imagefileNativePath:String;
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		public function MessageTests( logger:ILogger )
		{
			_l = logger;
			try
			{
				log( "Message.isSupported = " + Message.isSupported );
				if (Message.isSupported)
				{
					log( "Message.version =     " + Message.service.version );
					
					Message.service.addEventListener( MessageEvent.MESSAGE_MAIL_ATTACHMENT_ERROR, message_errorHandler );
					Message.service.addEventListener( MessageEvent.MESSAGE_MAIL_COMPOSE, message_composeHandler );
					Message.service.addEventListener( MessageEvent.MESSAGE_MAIL_COMPOSE_COMPLETE, message_composeHandler );
					Message.service.addEventListener( MessageEvent.MESSAGE_MAIL_COMPOSE_CANCELLED, message_composeHandler );
					
					Message.service.smsManager.addEventListener( MessageSMSEvent.MESSAGE_SMS_CANCELLED, message_smsEventHandler );
					Message.service.smsManager.addEventListener( MessageSMSEvent.MESSAGE_SMS_DELIVERED, message_smsEventHandler );
					Message.service.smsManager.addEventListener( MessageSMSEvent.MESSAGE_SMS_RECEIVED, message_smsEventHandler );
					Message.service.smsManager.addEventListener( MessageSMSEvent.MESSAGE_SMS_SENT, message_smsEventHandler );
					Message.service.smsManager.addEventListener( MessageSMSEvent.MESSAGE_SMS_SENT_ERROR, message_smsEventHandler );
					
					Message.service.addEventListener( ShareEvent.COMPLETE, message_shareHandler );
					Message.service.addEventListener( ShareEvent.CANCELLED, message_shareHandler );
					Message.service.addEventListener( ShareEvent.FAILED, message_shareHandler );
					
					
					// Create some files for using as attachments
					
					textfileNativePath = createAttachmentTextFile( "text.txt" ).nativePath;
					imagefileNativePath = createAttachmentImageFile( "image.jpg" ).nativePath;
					
					
				}
			}
			catch (e:Error)
			{
				trace( e );
			}
		}
		
		
		public function sendMail():void
		{
			if (Message.isMailSupported)
			{
				log( " === SENDING EMAIL === " );
				
				Message.service.sendMail(
						"Sending email from AIR",
						"This is the content of the email\n\nSent using the distriqt Message ANE",
						"email@address.com"
				);
			}
			else
			{
				log( " MAIL NOT SUPPORTED " );
			}
		}
		
		
		public function sendMailWithOptions():void
		{
			if (Message.isMailSupported)
			{
				log( " === SENDING EMAIL === " );
				
				var email:String = "ma@distriqt.com";
				var subject:String = "Sending email from AIR";

//				var body:String = "<table>" +
//					"<tr><td<strong>body</strong></td></tr>"+
//					"<tr><td></td></tr>"+
//					"<tr><td><img src='http://airnativeextensions.com/images/home/icon-support.png'/></td></tr>"+
//					"<tr><td><a href='http://airnativeextensions.com'>airnativeextensions link</a></td></tr>" +
//					"</table>";

//				var body:String = "This email was sent using the distriqt Message AIR native extension";
				
				var body:String =
							"<div>" +
							"<p>This HTML email was sent using the distriqt <b>Message ANE</b></p>" +
							"A link: <a href='http://airnativeextensions.com'>airnativeextensions.com</a>" +
							"<br/>" +
							"Block: <blockquote>Some quote</blockquote>" +
							"<br/>" +
							"Bold: <b>This text should be bold</b>" +
							"<br/>" +
							"Italic: <i>This text should be italic</i>" +
							"<br/>" +
							"Colour: <font color='#ff0000'>This text should be red</font>" +
						
							"<div/>";
				
				
				Message.service.sendMailWithOptions(
						subject,
						body,
						email,
						"test@test.cc.com",
						"",
						[ new MessageAttachment( imagefileNativePath, "image/jpeg" ) ],
						true
				);
			}
			else
			{
				log( " MAIL NOT SUPPORTED " );
			}
		}
		
		
		public function sendSMS():void
		{
			if (Message.service.smsManager.isSMSSupported)
			{
				log( " === SENDING SMS === " );
				
				var sms:SMS = new SMS();
				sms.address = "0444444444";
				sms.message = "Testing Message ANE";
				
				Message.service.smsManager.sendSMS( sms );
			}
		}
		
		
		public function sendSMSWithUI():void
		{
			if (Message.service.smsManager.isSMSSupported)
			{
				log( " === SENDING SMS WITH UI === " );
				
				var sms:SMS = new SMS();
				sms.address = "0444444444";
				sms.message = "Testing Message ANE";
				
				Message.service.smsManager.sendSMSWithUI( sms, false );
			}
		}
		
		
		//
		//
		//
		
		
		private function createAttachmentInfoFile( filename:String ):File
		{
			var file:File = File.applicationStorageDirectory.resolvePath( filename );
			var stream:FileStream = new FileStream();
			stream.open( file, FileMode.WRITE );
			stream.writeUTFBytes( "some-custom-data" );
			stream.close();
			return file;
		}
		
		
		private function createAttachmentTextFile( filename:String ):File
		{
			var file:File = File.applicationStorageDirectory.resolvePath( filename );
			var stream:FileStream = new FileStream();
			stream.open( file, FileMode.WRITE );
			stream.writeUTFBytes( "This is the attachment" );
			stream.close();
			
			return file;
		}
		
		
		private function createAttachmentImageFile( filename:String ):File
		{
			var bd:BitmapData = new BitmapData( 100, 100, false, 0x222222 );
			
			var jpg:JPGEncoder = new JPGEncoder( 50 );
			var ba:ByteArray = jpg.encode( bd );
			
			var file:File = File.applicationStorageDirectory.resolvePath( filename );
			var stream:FileStream = new FileStream();
			stream.open( file, FileMode.WRITE );
			stream.writeBytes( ba );
			stream.close();
			
			return file;
		}
		
		
		////////////////////////////////////////////////////////
		// 	AUTHORISATION
		//
		
		public function authorisationStatus():void
		{
			if (Message.isSupported)
			{
				log( "authorisationStatus = " + Message.service.smsManager.authorisationStatus() );
			}
		}
		
		
		public function checkAuthorisation():void
		{
			if (Message.isSupported)
			{
				
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
						// AUTHORISED: Camera will be available
						break;
				}
				
			}
		}
		
		
		private function authorisationChangedHandler( event:AuthorisationEvent ):void
		{
			log( "authorisationChanged: " + event.status );
		}
		
		
		//
		//
		//	EXTENSION HANDLERS
		//
		//		
		
		private function message_errorHandler( event:MessageEvent ):void
		{
			log( event.type + "::" + event.details );
		}
		
		
		private function message_composeHandler( event:MessageEvent ):void
		{
			log( event.type + "::" + event.details );
		}
		
		
		private function message_smsEventHandler( event:MessageSMSEvent ):void
		{
			log( event.type + "::" + event.details + "::" + event.sms.toString() );
		}
		
		
		private function message_shareHandler( event:ShareEvent ):void
		{
			log( event.type + "::" + event.activityType + "::" + event.error );
		}
		
		
	}
	
}

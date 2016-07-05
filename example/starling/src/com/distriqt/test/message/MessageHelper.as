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
	import com.distriqt.extension.message.Message;
	import com.distriqt.extension.message.MessageAttachment;
	import com.distriqt.extension.message.events.MessageEvent;
	import com.distriqt.extension.message.events.MessageSMSEvent;
	import com.distriqt.extension.message.events.ShareEvent;
	import com.distriqt.extension.message.objects.SMS;
	
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	/**	
	 */
	public class MessageHelper
	{
		
		[Embed("/image.png")]
		public var Image:Class;
		
		private var _messageCallback : Function;
		private function message( text:String ):void
		{
			if (_messageCallback != null) 
			{
				_messageCallback( text );
			}
		}
		
		
		private var textfileNativePath:String;
		private var imagefileNativePath:String;
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		public function MessageHelper( message:Function )
		{
			_messageCallback = message;
			try
			{
				Message.init( Config.distriqtApplicationKey );
				if (Message.isSupported)
				{
					Message.service.addEventListener( MessageEvent.MESSAGE_MAIL_ATTACHMENT_ERROR, 	message_errorHandler, 	false, 0, true );
					Message.service.addEventListener( MessageEvent.MESSAGE_MAIL_COMPOSE, 			message_composeHandler, false, 0, true );
					
					Message.service.addEventListener( MessageSMSEvent.MESSAGE_SMS_CANCELLED, 		message_smsEventHandler, false, 0, true );
					Message.service.addEventListener( MessageSMSEvent.MESSAGE_SMS_DELIVERED, 		message_smsEventHandler, false, 0, true );
					Message.service.addEventListener( MessageSMSEvent.MESSAGE_SMS_RECEIVED, 		message_smsEventHandler, false, 0, true );
					Message.service.addEventListener( MessageSMSEvent.MESSAGE_SMS_SENT, 			message_smsEventHandler, false, 0, true );
					Message.service.addEventListener( MessageSMSEvent.MESSAGE_SMS_SENT_ERROR, 		message_smsEventHandler, false, 0, true );
					
					Message.service.addEventListener( ShareEvent.COMPLETE,	message_shareHandler, false, 0, true );
					Message.service.addEventListener( ShareEvent.CANCELLED,	message_shareHandler, false, 0, true );
					Message.service.addEventListener( ShareEvent.FAILED, 	message_shareHandler, false, 0, true );
					
					
					// Create some files for using as attachments
					
					textfileNativePath  = createAttachmentTextFile( "text.txt" ).nativePath;
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
				message( " === SENDING EMAIL === " );
			
				Message.service.sendMail( 
					"Sending email from AIR", 
					"This email was sent using the distriqt Message AIR native extension",
					"email@address.com" 
				);
			}
		}
		
		public function sendMailWithOptions():void
		{
			if (Message.isMailSupported)
			{
				message( " === SENDING EMAIL === " );
				
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
					"<div>"+
					"<p>This HTML email was sent using the distriqt <b>Message ANE</b></p>"+
					"A link: <a href='http://airnativeextensions.com'>airnativeextensions.com</a>"+
					"<br/>" +
					"Block: <blockquote>Some quote</blockquote>"+
					"<br/>" +
					"Bold: <b>This text should be bold</b>"+
					"<br/>" +
					"Italic: <i>This text should be italic</i>"+
					"<br/>" +
					"Colour: <font color='#ff0000'>This text should be red</font>"+

					"<div/>" ;
					
				
				
				Message.service.sendMailWithOptions( 
					subject, 
					body, 
					email, 
					"",
					"",
					[
						new MessageAttachment( textfileNativePath,  "text/plain" ),
						new MessageAttachment( imagefileNativePath, "image/jpeg" )
					],
					true
				);
			}			
		}
		
		
		public function sendSMS():void
		{
			if (Message.isSMSSupported)
			{
				message( " === SENDING SMS === " );
				
				var sms:SMS = new SMS();
				sms.address = "12345";
				sms.message = "Testing Message ANE";
				
				Message.service.sendSMS( sms );
			}
		}
		
		
		public function sendSMSWithUI():void
		{
			if (Message.isSMSSupported)
			{
				message( " === SENDING SMS WITH UI === " );
				
				var sms:SMS = new SMS();
				sms.address = "0444444444";
				sms.message = "Testing Message ANE";
				
				Message.service.sendSMSWithUI( sms, false );
			}
		}
		
		
		//
		//
		//
		
		
		private function createAttachmentInfoFile( filename:String ):File
		{
			var file:File = File.createTempDirectory().resolvePath( filename );
			var stream:FileStream = new FileStream();
			stream.open(file, FileMode.WRITE);
			stream.writeUTFBytes("some-custom-data");
			stream.close();
			return file;
		}
		
		
		private function createAttachmentTextFile( filename:String ):File
		{
			var file:File = File.documentsDirectory.resolvePath( filename );
			var stream:FileStream = new FileStream();
			stream.open(file, FileMode.WRITE);
			stream.writeUTFBytes("This is the attachment");
			stream.close();
			
			return file;
		}
		
		
		private function createAttachmentImageFile( filename:String ):File
		{
			var bd:BitmapData = new BitmapData( 100, 100, false, 0x222222 ); 
			
			var jpg:JPGEncoder = new JPGEncoder(50);
			var ba:ByteArray = jpg.encode( bd );
			
			var file:File = File.documentsDirectory.resolvePath( filename );
			var stream:FileStream = new FileStream();
			stream.open(file, FileMode.WRITE);
			stream.writeBytes(ba);
			stream.close();
			
			return file;
		}
		
		
		
		
		
		//
		//
		//	EXTENSION HANDLERS
		//
		//		
		
		private function message_errorHandler( event:MessageEvent ):void 
		{
			message( event.type +"::"+ event.details );
		}
		
		private function message_composeHandler( event:MessageEvent ):void 
		{
			message( event.type +"::"+ event.details );
		}
		
		
		private function message_smsEventHandler( event:MessageSMSEvent ):void
		{
			message( event.type +"::"+ event.details + "::"+event.sms.toString() );
		}
		
		
		private function message_shareHandler( event:ShareEvent ):void
		{
			message( event.type + "::" + event.activityType + "::" + event.error );
		}
		
		
	}
}

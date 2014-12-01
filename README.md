


This extension was built by distriqt // 

# Message 

This extension provides functionality to send an email with attachments and to send SMS.


Features

- Email
-- Provides ability to compose an email using the native UI
-- Multiple To, CC and BCC Addresses
-- Multiple Attachments using a file path reference
-- Default implementation using a "mailto" link
- SMS
-- Create an SMS and send with the native UI
-- Send an SMS without UI on Android
- Sample project code and ASDocs reference


## Documentation

Latest documentation:

http://airnativeextensions.com/extension/com.distriqt.Message

```actionscript
if (Message.isMailSupported)
{
	Message.service.sendMailWithOptions(
		"Subject",
		"Body of email",
		"test@distriqt.com" );
}
```


## License

You can purchase a license for using this extension:

http://airnativeextensions.com

distriqt retains all copyright.



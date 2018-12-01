
## Add the Extension

First step is always to add the extension to your development environment. 
To do this use the tutorial located [here](https://airnativeextensions.com/knowledgebase/tutorial/1).



## Required ANEs

### Core ANE

The Core ANE is required by this ANE. You must include and package this extension in your application.

The Core ANE doesn't provide any functionality in itself but provides support libraries and frameworks used by our extensions.
It also includes some centralised code for some common actions that can cause issues if they are implemented in each individual extension.

You can access this extension here: [https://github.com/distriqt/ANE-Core](https://github.com/distriqt/ANE-Core).



### Android Support ANE

Due to several of our ANE's using the Android Support library the library has been separated into a separate ANE allowing you to avoid conflicts and duplicate definitions. This means that you need to include the some of the android support native extensions in your application along with this extension.

You will add these extensions as you do with any other ANE, and you need to ensure it is packaged with your application. There is no problems including this on all platforms, they are just **required** on Android.

This ANE requires the following Android Support extensions:

- [com.distriqt.androidsupport.V4.ane](https://github.com/distriqt/ANE-AndroidSupport/raw/master/lib/com.distriqt.androidsupport.V4.ane)

You can access these extensions here: [https://github.com/distriqt/ANE-AndroidSupport](https://github.com/distriqt/ANE-AndroidSupport).


> 
> Note: if you have been using the older `com.distriqt.AndroidSupport.ane` you should remove that ANE 
> and replace it with the equivalent `com.distriqt.androidsupport.V4.ane`. This is the new version of 
> this ANE and has been renamed to better identify the ANE with regards to its contents.
>


## Extension IDs

The following should be added to your `extensions` node in your application descriptor to identify all the required ANEs in your application:

```xml
<extensions>
    <extensionID>com.distriqt.Message</extensionID>
    <extensionID>com.distriqt.Core</extensionID>
    <extensionID>com.distriqt.androidsupport.V4</extensionID>
</extensions>
```




## Android: Manifest Additions

The Message ANE requires a few additions to the manifest to be able to start certain activities and to get permission to send and receive SMS. 
You will need to replace any occurrences of `APPLICATION_ID` with your application package name (generally your application id prefixed by `air.`)

You should add the listing below to your manifest:

```xml
<manifest android:installLocation="auto">
	<uses-permission android:name="android.permission.INTERNET"/>
	<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
	
	<uses-permission android:name="android.permission.SEND_SMS" /> 
	<uses-permission android:name="android.permission.READ_SMS" /> 
	<uses-permission android:name="android.permission.RECEIVE_SMS" />
	
	<application>

		<provider
			android:name="com.distriqt.extension.message.content.MessageFileProvider"
			android:authorities="APPLICATION_ID.messagefileprovider"
			android:grantUriPermissions="true"
			android:exported="false">
			<meta-data
				android:name="android.support.FILE_PROVIDER_PATHS"
				android:resource="@xml/distriqt_message_paths" />
		</provider>

	
		<!-- TO RECEIVE SMS -->
		<receiver android:name="com.distriqt.extension.message.receivers.MessageSMSReceiver" android:exported="true" > 
			<intent-filter android:priority="1000"> 
				<action android:name="android.provider.Telephony.SMS_RECEIVED" />
			</intent-filter> 
		</receiver>

		<!-- PERMISSIONS -->
		<activity android:name="com.distriqt.extension.message.permissions.AuthorisationActivity" android:theme="@android:style/Theme.Translucent.NoTitleBar" />

	</application>
</manifest>
```




## Checking for Support

You can use the `isSupported` flag to determine if this extension is supported on the current platform and device.

This allows you to react to whether the functionality is available on the device and provide an alternative solution if not.


```as3
if (Message.isSupported)
{
	// Functionality here
}
```


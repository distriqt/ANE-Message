
## Add the Extension

First step is always to add the extension to your development environment. 
To do this use the tutorial located [here](https://airnativeextensions.com/knowledgebase/tutorial/1).



## Required ANEs

### Core ANE

The Core ANE is required by this ANE. You must include and package this extension in your application.

The Core ANE doesn't provide any functionality in itself but provides support libraries and frameworks used by our extensions.
It also includes some centralised code for some common actions that can cause issues if they are implemented in each individual extension.

You can access this extension here: [https://github.com/distriqt/ANE-Core](https://github.com/distriqt/ANE-Core).




## Android: Manifest Additions

The Message ANE requires a few additions to the manifest to be able to start certain 
activities and to get permission to send and receive SMS. 

You should add the listing below to your manifest:

```xml
<manifest android:installLocation="auto">
	<uses-permission android:name="android.permission.INTERNET"/>
	<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
	
	<uses-permission android:name="android.permission.WRITE_SMS" />
	<uses-permission android:name="android.permission.SEND_SMS" /> 
	<uses-permission android:name="android.permission.READ_SMS" /> 
	<uses-permission android:name="android.permission.RECEIVE_SMS" />
	
	<application>
	
		<activity android:name="com.distriqt.extension.message.activities.SendMailActivity" android:theme="@android:style/Theme.Translucent.NoTitleBar"></activity>
		<activity android:name="com.distriqt.extension.message.activities.ShareActivity" android:theme="@android:style/Theme.Translucent.NoTitleBar"></activity>
		
		<receiver android:name="com.distriqt.extension.message.receivers.MessageSMSReceiver" android:exported="true" > 
			<intent-filter android:priority="1000"> 
				<action android:name="android.provider.Telephony.SMS_RECEIVED" />
			</intent-filter> 
		</receiver>
		
	</application>
</manifest>
```


###### 2015.06.22

Android: Fix for sending SMS with Hangouts in API > 19 (resolves #16)


###### 2015.06.16

Removed debug code from AS lib
iOS: Updated to latest common lib
Android: Windows: Fix for bug in AIR packager resulting in missing resources


###### 2015.06.09

Android: Windows: Fix for bug in AIR packager resulting in missing resources (resolves #11)


###### 2015.04.07

Added an 'id' to the SMS object that gets returned with send events (resolves #13)
Android: Added the ability to send SMS messages longer than 160 characters (resolves #14)
Corrected the returned SMS object on send events (resolves #12)
Android: Removed unused resources (resolves #11)


###### 2015.03.17

Added share activity to allow sharing of text/url/image (resolves #10)
Android: Fixed issue with sendMail when intent failed to be created


###### 2015.02.12

Moved to new structure to support FlashBuilder 4.6 (#6)


###### 2015.02.03

Android: Copied attachments to a temporary cache so external applications can access the files (resolves #3)


###### 2015.02.02

Added check for .debug suffix in application id


###### 2014.12.22

iOS: Included arm64 support (resolves #5) 
Android: Corrected application id check when doesn't contain air prefix


###### 2014.12.22

iOS: Included arm64 support (resolves #2) 
Android: Corrected application id check when doesn't contain air prefix (resolves #1)


###### 2014.12.05

Added CHANGELOG


###### 2014.12.05

Corrected missing EventDispatcher functions from base class
iOS: Implemented autoreleasepools for all C function calls


###### 2014.12.01

New application based key check, removing server checks
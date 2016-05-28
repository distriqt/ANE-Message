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
 * @file   		Main.as
 * @created		08/01/2016
 */
package com.distriqt.test.message
{
	import flash.system.Capabilities;
	
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.layout.VerticalLayout;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**	
	 * 
	 */
	public class Main extends Sprite
	{
		////////////////////////////////////////////////////////
		//	CONSTANTS
		//
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		private var _helper							: MessageHelper;

		
		//	UI
		
		private var _group							: LayoutGroup;
		
		private var _button_sendMail				: Button;
		private var _button_sendMailWithOptions		: Button;

		private var _button_sendSMS					: Button;
		private var _button_sendSMSWithUI			: Button;
		
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		
		/**
		 *  Constructor
		 */
		public function Main()
		{
			super();
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
		}
		
		
		
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		private function init():void
		{
			_helper = new MessageHelper( message );
		}
		
		
		private function message( text:String ):void
		{
			trace( text );
		}
		
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
		protected function addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler );
			
			var theme:MetalWorksMobileTheme = new MetalWorksMobileTheme();
			
			Config.scale = 2 * Capabilities.screenDPI / theme.originalDPI;
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 3 * Config.scale;
			
			_group = new LayoutGroup();
			_group.layout = layout;
			_group.x = 10 * Config.scale;
			_group.y = 5 + 40 * (Config.scale - 1);
			addChild( _group );
			
			_button_sendMail = new Button();
			_button_sendMail.label = "Send Mail";
			_button_sendMail.addEventListener( Event.TRIGGERED, button_sendMail_triggeredHandler );
			
			_button_sendMailWithOptions = new Button();
			_button_sendMailWithOptions.label = "Send Mail With Options";
			_button_sendMailWithOptions.addEventListener( Event.TRIGGERED, button_sendMailWithOptions_triggeredHandler );
			
			
			_button_sendSMS = new Button();
			_button_sendSMS.label = "Send SMS";
			_button_sendSMS.addEventListener( Event.TRIGGERED, button_sendSMS_triggeredHandler );
			
			_button_sendSMSWithUI = new Button();
			_button_sendSMSWithUI.label = "Send SMS With UI";
			_button_sendSMSWithUI.addEventListener( Event.TRIGGERED, button_sendSMSWithUI_triggeredHandler );
			
			
			_group.addChild( _button_sendMail );
			_group.addChild( _button_sendMailWithOptions );
			
			_group.addChild( _button_sendSMS );
			_group.addChild( _button_sendSMSWithUI );
		
			init();
		}

		
		private function button_sendMail_triggeredHandler( event:Event ):void
		{
			_helper.sendMail();
		}

		private function button_sendMailWithOptions_triggeredHandler( event:Event ):void
		{
			_helper.sendMailWithOptions();
		}

		private function button_sendSMS_triggeredHandler( event:Event ):void
		{
			_helper.sendSMS();
		}
		
		private function button_sendSMSWithUI_triggeredHandler( event:Event ):void 
		{
			_helper.sendSMSWithUI();
		}
		
		
		
	}
}
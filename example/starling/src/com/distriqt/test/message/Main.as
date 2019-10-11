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
	import feathers.controls.ScrollContainer;
	import feathers.layout.HorizontalAlign;
	import feathers.layout.VerticalAlign;
	
	import flash.system.Capabilities;
	
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.layout.VerticalLayout;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.utils.Color;
	
	/**	
	 * 
	 */
	public class Main extends Sprite implements ILogger
	{
		////////////////////////////////////////////////////////
		//	CONSTANTS
		//
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		private var _tests		: MessageTests;

		
		//	UI
		
		private var _buttons	: Vector.<Button>;
		private var _container	: ScrollContainer;
		private var _text		: TextField;
		
		
		
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
		
		
		public function log( tag:String, message:String ):void
		{
			trace( tag+"::"+message );
			if (_text)
				_text.text = tag+"::"+message + "\n" + _text.text ;
		}
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		private function init():void
		{
			var marginTop:Number = 0;
			
			var tf:TextFormat = new TextFormat( "_typewriter", 12, Color.WHITE, HorizontalAlign.LEFT, VerticalAlign.TOP );
			_text = new TextField( stage.stageWidth, stage.stageHeight, "", tf );
			_text.y = marginTop;
			_text.touchable = false;
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.horizontalAlign = HorizontalAlign.RIGHT;
			layout.verticalAlign = VerticalAlign.BOTTOM;
			layout.gap = 5;
			
			_container = new ScrollContainer();
			_container.y = marginTop;
			_container.layout = layout;
			_container.width = stage.stageWidth;
			_container.height = stage.stageHeight-_container.y;
			
			
			_tests = new MessageTests( this );
			addChild( _tests );
			
			addAction( "Send Mail", _tests.sendMail );
			addAction( "Send Mail With Options", _tests.sendMailWithOptions );
			
			addAction( "Status :SMS", _tests.authorisationStatus );
			addAction( "Check :SMS", _tests.checkAuthorisation );
			addAction( "Send SMS :SMS", _tests.sendSMS );
			addAction( "Send SMS Via Sub :SMS", _tests.sendSMSViaSubscription );
			addAction( "Send SMS With UI :SMS", _tests.sendSMSWithUI );
			
			
			addChild( _text );
			addChild( _container );
			
		}
		
		
		private function addAction( label:String, listener:Function ):void
		{
			var b:Button = new Button();
			b.label = label;
			b.addEventListener( starling.events.Event.TRIGGERED, listener );
			_container.addChild( b );
		}
		
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
		protected function addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler );
			var theme:MetalWorksMobileTheme = new MetalWorksMobileTheme();
			init();
		}
		
		
		
	}
}
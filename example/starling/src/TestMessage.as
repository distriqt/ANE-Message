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
 * @file   		TestMessage.as
 * @created		28/05/2016
 */
package
{
	import com.distriqt.test.message.Main;
	
	import feathers.utils.ScreenDensityScaleFactorManager;
	
	import flash.desktop.NativeApplication;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	
	
	/**	
	 * 
	 */
	public class TestMessage extends Sprite
	{
		////////////////////////////////////////////////////////
		//	CONSTANTS
		//
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		private var _starling:Starling;
		private var _scaler:ScreenDensityScaleFactorManager;
		
		private var _debugView:Sprite;
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		
		/**
		 *  Constructor
		 */
		public function TestMessage()
		{
			super();
			if(this.stage)
			{
				stage.align        = StageAlign.TOP_LEFT;
				stage.scaleMode    = StageScaleMode.NO_SCALE;
				stage.displayState = StageDisplayState.NORMAL;
			}
			this.mouseEnabled = this.mouseChildren = false;
			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
			
			_debugView = new Sprite();
			addChild( _debugView );
			
		}
		
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
		private function loaderInfo_completeHandler(event:Event):void
		{
			Starling.multitouchEnabled = true;
//			_starling = new Starling( Main, this.stage, null, null, Context3DRenderMode.AUTO, Context3DProfile.BASELINE );
			_starling = new Starling( Main, this.stage );
//			_starling.enableErrorChecking = false;
//			_starling.skipUnchangedFrames = false;
//			_starling.supportHighResolutions = false;
			_starling.supportHighResolutions = true;
			_starling.start();
			
			_scaler = new ScreenDensityScaleFactorManager(_starling);
			
			stage.addEventListener(Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
		}
		
		
		private function stage_deactivateHandler(event:Event):void
		{
			_starling.stop(true);
			stage.addEventListener(Event.ACTIVATE, stage_activateHandler, false, 0, true);
		}
		
		
		private function stage_activateHandler(event:Event):void
		{
			stage.removeEventListener(Event.ACTIVATE, stage_activateHandler);
			_starling.start();
		}
		
		
	}
}
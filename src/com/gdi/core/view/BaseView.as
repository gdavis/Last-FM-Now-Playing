package com.gdi.core.view {
	import com.factorylabs.orange.core.IDisposable;
	import com.factorylabs.orange.core.display.FSprite;

	/**
	 * @author grantdavis
	 */
	public class BaseView 
		extends FSprite
			implements IDisposable {
			
		protected var _controller	:ViewController;
		
		public function BaseView( $contoller :ViewController, $options :Object=null ) :void
		{
			super( null, $options );
			_controller = $contoller;
		}
		
		
		
		public function dispose() :void
		{
			_controller = null;	
		}
	}
}

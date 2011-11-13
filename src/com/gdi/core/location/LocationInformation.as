package com.gdi.core.location {

	/**
	 * @author grantdavis
	 */
	public class LocationInformation {
		protected var _displayName : String;
		protected var _friendlyUrl : String;
		protected var _controllerClass : Class;

		public function get displayName() :String { return _displayName; }
		public function set displayName( $displayName :String ) :void
		{
			_displayName = $displayName;
		}
		
		public function get friendlyUrl() :String { return _friendlyUrl; }
		public function set friendlyUrl( $friendlyUrl :String ) :void
		{
			_friendlyUrl = $friendlyUrl;
		}
		
		public function get controllerClass() :Class { return _controllerClass; }
		public function set controllerClass( $controllerClass :Class ) :void
		{
			_controllerClass = $controllerClass;
		}
	}
}

package com.gdi.core.location {
	import com.adobe.serialization.json.JSON;
	import flash.net.URLLoader;

	/**
	 * @author grantdavis
	 */
	public class LocationManager {
		
		protected var _loader	:URLLoader;
		protected var _json	:JSON;
		
		public function LocationManager( $json :JSON ) :void
		{
			_json = $json;
			
		}
	}
}

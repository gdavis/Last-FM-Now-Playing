package com.gdi.core.location {
	import com.factorylabs.orange.core.collections.Map;
	import com.factorylabs.orange.core.IDisposable;
	import com.factorylabs.orange.core.gc.Janitor;
	import com.gdi.core.model.BaseModel;

	/**
	 * @author grantdavis
	 */
	public class LocationController
		implements IDisposable, ILocationController {
			
		protected var _model	:BaseModel;
		protected var _janitor	:Janitor;
		protected var _locationInformation : LocationInformation;

		public function LocationController( $model :BaseModel , $locationInformation :LocationInformation ) :void
		{
			super();
			_model = $model;
			_locationInformation = $locationInformation;
			_janitor = new Janitor( this );
		}

		public function dispose() :void
		{
			_janitor.cleanUp();
			_janitor = null;
			_model = null;
			_locationInformation = null;
		}

		public function locationWillBecomeActive() : void {
		}
		
		public function activateLocation($options : Map) : void {
			
		}
		
		public function locationDidBecomeActive() : void {
		}
		
		public function locationWillBecomeInactive() : void {
		}
		
		public function deactivateLocation() : void {
		}
		
		public function locationDidBecomeInactive() : void {
		}
		
		public function get locationInformation() : LocationInformation {
			return _locationInformation;
		}
		
		public function set locationInformation($locationInformation : LocationInformation) : void {
			_locationInformation = $locationInformation;
		}
	}
}

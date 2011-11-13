package com.gdi.core.location {
	import com.factorylabs.orange.core.collections.Map;

	/**
	 * @author grantdavis
	 */
	public interface ILocationController {
		
		function locationWillBecomeActive():void;
		function activateLocation( $options :Map ):void;
		function locationDidBecomeActive():void;
		
		function locationWillBecomeInactive():void;
		function deactivateLocation():void;
		function locationDidBecomeInactive():void;
		
		function get locationInformation() :LocationInformation;
		function set locationInformation( $locationInformation :LocationInformation ) :void;
	}
}

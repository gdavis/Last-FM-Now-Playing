package com.gravitygaming.lastfm.app.net {
	import com.adobe.serialization.json.JSONDecoder;
	import com.factorylabs.orange.core.net.LoadItem;

	import org.osflash.signals.Signal;

	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.Timer;

	/**
	 * @author grantdavis
	 */
	public class RecentTracksMonitor extends Object {
		
		public function get updateSignal() :Signal { return _updateSignal; }
		private var _updateSignal	:Signal;
		
		private var _timer	:Timer;
		private var _url	:String;
		private var _loader	:LoadItem;
		private var _isLoading	:Boolean;
		private var _lastSongName	:String;
		
		public function RecentTracksMonitor( $apiKey :String, $user :String ) {
			
			_url = "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&format=json&limit=4&api_key=" + $apiKey + "&user=" + $user;
			_timer = new Timer( 1000 * 15 );
			_timer.addEventListener( TimerEvent.TIMER, handleTimerTick );
			
			_updateSignal = new Signal( Object );
			_lastSongName = "";
		}

		public function startMonitoring() :void
		{
			_timer.reset();
			_timer.start();
			requestRecentTracks();
		}
		
		public function stopMonitoring() :void
		{
			_timer.reset();
		}
		
		private function update() :void
		{
			if (!_isLoading) {
				requestRecentTracks();
			}
		}
		
		private function requestRecentTracks() :void
		{
			var request :URLRequest = new URLRequest(_url);
			request.method = URLRequestMethod.GET;
			
			_loader = new LoadItem( request, LoadItem.TYPE_TEXT);
			_loader.completeSignal.add(handleComplete);
			_loader.errorSignal.add(handleError);
			_loader.start();
		}
		
		
		private function destroyLoader() :void {
			_loader.dispose();
			_loader = null;	
		}

		
		private function handleTimerTick( $e :TimerEvent ) :void
		{
			update();
		}
		
		private function handleComplete( $loader :LoadItem ) :void {
			_isLoading = false;
				
			try {
				var decoder :JSONDecoder = new JSONDecoder( $loader.textContent, false);
				var json :Object = decoder.getValue();
				var firstSong :String = json['recenttracks']['track'][0]['name'];
				if( _lastSongName != firstSong ) {
					_lastSongName = firstSong;
					_updateSignal.dispatch( json );	
				}
			}
			catch ( $e :* ) {
				// hide erro
			}
			
			destroyLoader();
		}
		
		private function handleError( $loader :LoadItem, $error :String ) :void {
			_isLoading = false;
			$loader = null;
			destroyLoader();
		}
	}
}

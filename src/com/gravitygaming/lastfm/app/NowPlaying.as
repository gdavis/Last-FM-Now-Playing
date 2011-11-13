package com.gravitygaming.lastfm.app {
	import com.gravitygaming.lastfm.app.display.CurrentTrackView;
	import com.gravitygaming.lastfm.app.net.RecentTracksMonitor;
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;

	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	/**
	 * @author grantdavis
	 */
	public class NowPlaying extends MovieClip {
		
		private static const API_KEY		:String = "cb8a8cc5c1d8a7285bef4e0ab9e07534";
		private static const USER			:String = "GravityGaming";
		private static const MAX_TRACKS		:uint = 4;
		private static const TRACK_PADDING	:int = 5;
		
		private var _recentTracksMonitor	:RecentTracksMonitor;
		private var _currentTracks			:Array;
		
		public function NowPlaying() {
			super();
			
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;			
			
			_recentTracksMonitor = new RecentTracksMonitor(API_KEY, USER);
			_recentTracksMonitor.updateSignal.add(handleTracksUpdate);
			_recentTracksMonitor.startMonitoring();
			
			_currentTracks = new Array();
		}

		private function handleTracksUpdate( $json :Object ) :void
		{			
			
			trace("\n\n*** Tracks updated! ***");
			var currentTrackData :Object = $json['recenttracks']['track'][0];
			var currentTrackView :CurrentTrackView = new CurrentTrackView( currentTrackData, this, { x:2, y:2, alpha:0 });
			_currentTracks.unshift(currentTrackView);
		
			// remove last
			if(_currentTracks.length > MAX_TRACKS) {
				
				var lastTrack :CurrentTrackView = _currentTracks.pop();
				lastTrack.active = false;
				TweenLite.to(lastTrack, 1, { alpha:0, onComplete:lastTrack.remove, ease:Expo.easeInOut });
			}
			
			// reposition list
			var dl : int = _currentTracks.length;
			var dx :int = 2;
			for (var i : int = 0; i < dl; i++) 
			{
				var trackView :CurrentTrackView = _currentTracks[i];
				trackView.active = i == 0 ? true :false;
				TweenLite.to(trackView, 1, { x:dx, alpha:1, delay: i==0 ? 1 : 0, ease:Expo.easeInOut });
				dx += trackView.width + TRACK_PADDING;
			}
		}
	}
}
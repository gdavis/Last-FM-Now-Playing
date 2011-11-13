package com.gravitygaming.lastfm.app {
	import com.factorylabs.orange.core.display.FTextField;
	import com.gravitygaming.lastfm.app.display.CurrentTrackView;
	import com.gravitygaming.lastfm.app.net.RecentTracksMonitor;
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;

	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.filters.DropShadowFilter;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * @author grantdavis
	 */
	public class NowPlaying extends MovieClip {
		
		private static const API_KEY		:String = "cb8a8cc5c1d8a7285bef4e0ab9e07534";
		private static const USER			:String = "GravityGaming";
		
		private var _recentTracksMonitor	:RecentTracksMonitor;
		private var _currentTrack			:CurrentTrackView;
		
		public function NowPlaying() {
			super();
			
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;			
			
			_recentTracksMonitor = new RecentTracksMonitor(API_KEY, USER);
			_recentTracksMonitor.updateSignal.add(handleTracksUpdate);
			_recentTracksMonitor.startMonitoring();
			
			var tf :FTextField = new FTextField(this, { x:2, alpha:.5 });
			tf.defaultTextFormat = new TextFormat("Arial", 12, 0xffffff, true );
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.text = "NOW PLAYING";
			tf.embedFonts = false;
			tf.filters = [new DropShadowFilter( 1, 45, 0x000000, 1, 1, 1)];
		}

		private function handleTracksUpdate( $json :Object ) :void
		{			
			
			trace("\n\n*** Tracks updated! ***");
			
			// hide previous track
			var hasPrevious :Boolean = false;
			if (_currentTrack) {
				TweenLite.to(_currentTrack, 1, { alpha: 0, ease:Expo.easeInOut });
				hasPrevious = true;
			}
			
			// grab the first track and display it.
			var currentTrackData :Object = $json['recenttracks']['track'][0];
			_currentTrack = new CurrentTrackView( currentTrackData, this, { y:18, alpha:0 });
			TweenLite.to(_currentTrack, 1, { delay: hasPrevious ? 1 : 0, alpha:1, ease:Expo.easeInOut });
		}
	}
}
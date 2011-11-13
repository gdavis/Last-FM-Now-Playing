package com.gravitygaming.lastfm.app.display {
	import flash.filters.DropShadowFilter;
	import com.factorylabs.orange.core.display.fills.SolidStroke;
	import com.factorylabs.orange.core.display.FSprite;
	import com.factorylabs.orange.core.display.FTextField;
	import com.factorylabs.orange.core.display.fills.SolidFill;
	import com.factorylabs.orange.core.display.graphics.FRectRound;
	import com.factorylabs.orange.core.display.graphics.FRectangle;
	import com.factorylabs.orange.core.net.LoadItem;

	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * @author grantdavis
	 */
	public class CurrentTrackView extends FSprite {
		
		private var _imageLoader	:LoadItem;
		private var _currentTrack	:Object;
		private var _image			:FSprite;
		
		public function CurrentTrackView($currentTrack :Object, $container : DisplayObjectContainer = null, $init : Object = null) {
			super($container, $init);
			
			_currentTrack = $currentTrack;		
			build();
		}
		
		private function build() :void
		{			
			var padding :int = 8;
			var textX :int = 8;
			var textY :int = 0;
			var textWidth :int = 0;
			var imageSize :int = 34;
			var height : int = 53;
			
			// setup data
			var song :String = _currentTrack['name'];
			var albumName :String = _currentTrack['album']['#text'];
			var artistName :String = _currentTrack['artist']['#text'];
			
			trace('song: ' + _currentTrack['name']);
			trace('albumName: ' + albumName);
			trace('artist: ' + artistName);
			
			// load image
			var imageUrl :String = _currentTrack["image"][0]['#text'];
			if (imageUrl && imageUrl.length > 0) {
				
				_image = new FSprite( this, {x:8, y:9});
				new FRectangle( _image.graphics, 0, 0, imageSize+2, imageSize+2, new SolidFill(0x000000));
				
				var request :URLRequest = new URLRequest(imageUrl);
				_imageLoader = new LoadItem( request, LoadItem.TYPE_DISPLAY);
				_imageLoader.context = new LoaderContext( true, null, null);
				_imageLoader.completeSignal.add(handleImageLoad);
				_imageLoader.start();

				textX = 53;
			}
			
			var container :FSprite = new FSprite(this);
			var textContainer :FSprite = new FSprite(container, { x:textX });
			
			// song
			var tf :FTextField = buildTextField(textContainer, textY, song.toUpperCase(), 0xffffff, true );
			textY += tf.textHeight;
			textWidth = (tf.textWidth > textWidth) ? tf.textWidth : textWidth; 
			
			// album
			if (albumName && albumName.length > 0) {
				tf = buildTextField(textContainer, textY, albumName, 0xcccccc);
				textY += tf.textHeight;
				textWidth = (tf.textWidth > textWidth) ? tf.textWidth : textWidth;
			}
			
			// arist
			tf = buildTextField(textContainer, textY, "by " + artistName, 0xcccccc);
			textY += tf.textHeight;
			textWidth = (tf.textWidth > textWidth) ? tf.textWidth : textWidth;
			
			// draw bgs
			new FRectRound( this.graphics, 0, 0, textX + textWidth + padding * 2, height, new SolidFill( 0x639ed8, .1 ), 10);
			new FRectRound( this.graphics, 0, 0, textX + textWidth + padding * 2, height, new SolidStroke( 0xffffff, .25 ), 10);
			
			// center text
			textContainer.y = height * .5 - textContainer.height * .5;
			
		}

		
		private function buildTextField( $container :DisplayObjectContainer, $yp :int, $txt :String, $color :uint, $bold :Boolean=false ) :FTextField
		{
			var tf :FTextField = new FTextField( $container, { y:$yp});
			tf.defaultTextFormat = new TextFormat("Arial", 12, $color, $bold );
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.text = $txt;
			tf.embedFonts = false;
			tf.filters = [new DropShadowFilter( 1, 45, 0x000000, 1, 1, 1)];
			return tf;
		}
		
		private function handleImageLoad( $e :LoadItem ) :void
		{
			var image :Bitmap = _imageLoader.displayContent as Bitmap;
			image.x = 1;
			image.y = 1;
			_image.addChild(image);	
			_imageLoader.dispose();
			_imageLoader = null;
			$e = null;
		}
	}
}

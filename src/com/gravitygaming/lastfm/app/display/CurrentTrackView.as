package com.gravitygaming.lastfm.app.display {
	import com.factorylabs.orange.core.display.FSprite;
	import com.factorylabs.orange.core.display.FTextField;
	import com.factorylabs.orange.core.display.fills.GradientFill;
	import com.factorylabs.orange.core.display.fills.SolidFill;
	import com.factorylabs.orange.core.display.fills.SolidStroke;
	import com.factorylabs.orange.core.display.graphics.FRectRound;
	import com.factorylabs.orange.core.display.graphics.FRectangle;
	import com.factorylabs.orange.core.net.LoadItem;

	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.LoaderContext;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * @author grantdavis
	 */
	public class CurrentTrackView extends FSprite {
		
		public function get active() :Boolean { return _active; }
		public function set active( $active :Boolean ) :void
		{
			_active = $active;
			drawBg();
		}
		
		[Embed(source="../../../../../../fonts/ArialBold.ttf", 
		    fontName = "_ArialBold", 
		    mimeType = "application/x-font", 
		    fontWeight="normal", 
		    fontStyle="normal", 
		    unicodeRange="U+0000-U+0FFF", 
		    advancedAntiAliasing="true", 
		    embedAsCFF="false")]
		private var _arialBold:Class;
      
		private static const PADDING	:uint = 8;
		private static const HEIGHT		:int = 53;
		private var _textWidth			:uint = 0;
		private var _textX				:uint = 8;
		private var _active				:Boolean;
		private var _imageLoader		:LoadItem;
		private var _currentTrack		:Object;
		private var _image				:FSprite;
		
		public function CurrentTrackView($currentTrack :Object, $container : DisplayObjectContainer = null, $init : Object = null) {
			super($container, $init);
			
			_currentTrack = $currentTrack;		
			build();
		}
		
		private function build() :void
		{			
			var textY :int = 0;
			var imageSize :int = 34;
			
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

				_textX = 53;
			}
			
			var container :FSprite = new FSprite(this);
			var textContainer :FSprite = new FSprite(container, { x:_textX });
			
			// song
			var tf :FTextField = buildTextField(textContainer, textY, song.toUpperCase(), 0xffffff, true );
			textY += tf.textHeight;
			_textWidth = (tf.textWidth > _textWidth) ? tf.textWidth : _textWidth; 
			
			// album
			if (albumName && albumName.length > 0) {
				tf = buildTextField(textContainer, textY, albumName, 0xffffff);
				textY += tf.textHeight;
				_textWidth = (tf.textWidth > _textWidth) ? tf.textWidth : _textWidth;
			}
			
			// arist
			tf = buildTextField(textContainer, textY, "by " + artistName, 0xffffff);
			textY += tf.textHeight;
			_textWidth = (tf.textWidth > _textWidth) ? tf.textWidth : _textWidth;
			
			// draw bgs
			drawBg();
			
			this.filters = [new DropShadowFilter(2, 45, 0x000000, .666, 5, 5)];
			
			// center text
			textContainer.y = height * .5 - textContainer.height * .5;
			
			// functionality
			this.useHandCursor = true;
			this.mouseEnabled = true;
			this.addEventListener( MouseEvent.CLICK, handleClick);
		}
		
		private function drawBg() :void
		{
			this.graphics.clear();
			var borderColor :uint = _active ? 0x9c0000 : 0x000000;
			var borderSize :uint = _active ? 2 : 1;
			new FRectRound( this.graphics, 0, 0, _textX + _textWidth + PADDING * 2, HEIGHT, new GradientFill(90, [0xa7b0b9,0x828b94,0xa7b0b9],[1,1,1],[0,127,255]), 10);
			new FRectRound( this.graphics, 0, 0, _textX + _textWidth + PADDING * 2, HEIGHT, new SolidStroke( borderColor, .5, borderSize, false), 10);
		}

		private function handleClick( $e :MouseEvent ) :void
		{
			navigateToURL( new URLRequest(_currentTrack['url']), "_blank" );
		}
		
		private function buildTextField( $container :DisplayObjectContainer, $yp :int, $txt :String, $color :uint, $bold :Boolean=false ) :FTextField
		{
			var tf :FTextField = new FTextField( $container, { y:$yp});
			tf.defaultTextFormat = new TextFormat("_ArialBold", 11, $color, $bold );
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.text = $txt;
			tf.filters = [new DropShadowFilter( 1, 45, 0x000000, 1, 1, 1)];
			return tf;
		}
		
		private function handleImageLoad( $e :LoadItem ) :void
		{
			try {
				var image :Bitmap = _imageLoader.displayContent as Bitmap;
				image.x = 1;
				image.y = 1;
				_image.addChild(image);	
				_imageLoader.dispose();
				_imageLoader = null;
			}
			catch ($e :* ) {
				
			}
			$e = null;
		}
	}
}

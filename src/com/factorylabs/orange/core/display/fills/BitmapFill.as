
package com.factorylabs.orange.core.display.fills
{
  import com.factorylabs.orange.core.display.graphics.IGraphic;

  import flash.display.BitmapData;
  import flash.display.Graphics;
  import flash.display.IBitmapDrawable;
  import flash.geom.ColorTransform;
  import flash.geom.Matrix;
  import flash.geom.Rectangle;

  /**
   * Fills a Graphic with a Bitmap Object.
   *
   * <p>For a description of the built in <code>Graphics.beginBitmapFill()</code> method see <code><a href="http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/Graphics.html#beginBitmapFill()">beginBitmapFill</a></code>.</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Jun 1, 2008
   *
   * TODO: I'm betting JG can make this thing smoother... like way smoother.
   */
  public class BitmapFill
    implements IFill
  {
    /**
     * @private
     */
    protected var _bitmapData   :BitmapData;

    /**
     * @private
     */
    protected var _source     :IBitmapDrawable;

    /**
     * @private
     */
    protected var _repeat     :Boolean;

    /**
     * @private
     */
    protected var _smooth     :Boolean;

    /**
     * @private
     */
    protected var _blendMode    :String;

    /**
     * @private
     */
    protected var _clipRect     :Rectangle;

    /**
     * @private
     */
    protected var _rotation     :Number;

    /**
     * @private
     */
    protected var _colorTransform :ColorTransform;

    /**
     * The BitmapData object being used.
     */
    public function get bitmapData() :BitmapData { return _bitmapData; }
    public function set bitmapData( $bitmapData :BitmapData ) :void
    {
      _bitmapData = $bitmapData;
    }

    /**
     * Reference to objects that can be passed as the <code>source</code> parameter of the <code>draw()</code> method of the BitmapData class.
     */
    public function get source() :IBitmapDrawable { return _source; }
    public function set source( $source :IBitmapDrawable ) :void
    {
      _source = $source;
    }

    /**
     * Whether to repeat the bitmap object within the fill.
     */
    public function get repeat() :Boolean { return _repeat; }
    public function set repeat( $repeat :Boolean ) :void
    {
      _repeat = $repeat;
    }

    /**
     * Whether to smooth the bitmap object within the fill.
     */
    public function get smooth() :Boolean { return _smooth; }
    public function set smooth( $smooth :Boolean ) :void
    {
      _smooth = $smooth;
    }

    /**
     * The blend filter being used on the bitmap.
     */
    public function get blendMode() :String { return _blendMode; }
    public function set blendMode( vBlendMode :String ) :void
    {
      _blendMode = vBlendMode;
    }

    /**
     * A Rectangle object that defines the area of the source object to draw.
     */
    public function get clipRect() :Rectangle { return _clipRect; }
    public function set clipRect( vClipRect :Rectangle ) :void
    {
      _clipRect = vClipRect;
    }

    /**
     * The rotation of the Bitmap object.
     */
    public function get rotation() :Number { return _rotation; }
    public function set rotation( $rotation :Number ) :void
    {
      _rotation = $rotation;
    }

    /**
     * The color transformation used on the Bitmap.
     */
    public function get colorTransform() :ColorTransform { return _colorTransform; }
    public function set colorTransform( $colorTransform :ColorTransform ) :void
    {
      _colorTransform = $colorTransform;
    }

    /**
     * Constructs a new BitmapFill fill.
     * @param $bitmapData     A transparent or opaque bitmap image that contains the bits to be displayed.
     * @param $source       The display object or BitmapData object to draw to the BitmapData object. (The DisplayObject and BitmapData classes implement the IBitmapDrawable interface.)
     * @param $repeat       If <code>true</code>, the bitmap image repeats in a tiled pattern. If <code>false</code>, the bitmap image does not repeat, and the edges of the bitmap are used for any fill area that extends beyond the bitmap.
     * @param $smooth       If <code>false</code>, upscaled bitmap images are rendered by using a nearest-neighbor algorithm and look pixelated. If <code>true</code>, upscaled bitmap images are rendered by using a bilinear algorithm. Rendering by using the nearest neighbor algorithm is usually faster.
     * @param $blendMode      A string value, from the flash.display.BlendMode class, specifying the blend mode to be applied to the resulting bitmap.
     * @param $clipRect       A Rectangle object that defines the area of the source object to draw. If you do not supply this value, no clipping occurs and the entire source object is drawn.
     * @param $rotation       The rotation in degrees used by the Matrix for applying the fill.
     * @param $colorTransform   A ColorTransform object that you use to adjust the color values of the bitmap. If no object is supplied, the bitmap image's colors are not transformed.
     *
     * @example The following code creates a Bitmap Fill.
     * <listing version="3.0" >
     * var bf :BitmapFill = new BitmapFill( new BitmapData( _loader.width, _loader.height, true ), _loader, true, true, BlendMode.OVERLAY, null, 0, null );
     * </listing>
     */
    public function BitmapFill( $bitmapData :BitmapData, $source :IBitmapDrawable, $repeat :Boolean = true, $smooth :Boolean = true, $blendMode :String = null, $clipRect :Rectangle = null, $rotation :Number = 0, $colorTransform :ColorTransform = null )
    {
      _bitmapData = $bitmapData;
      _source = $source;
      _repeat = $repeat;
      _smooth = $smooth;
      _blendMode = $blendMode;
      _clipRect = $clipRect;
      _rotation = $rotation;
      _colorTransform = $colorTransform;
    }

    /**
     * @return  The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.fills.BitmapFill';
    }

    /**
     * @inheritDoc
     */
    public function begin( $gfx :Graphics, $igfx :IGraphic ) :void
    {
      _bitmapData.draw( _source, null, _colorTransform, _blendMode, _clipRect, _smooth );
      var matrix :Matrix = new Matrix();
      matrix.createGradientBox( $igfx.width, $igfx.height, degreesToRadians( _rotation ), $igfx.x, $igfx.y );
      $gfx.beginBitmapFill( _bitmapData, matrix, _repeat, _smooth );
    }

    /**
     * @inheritDoc
     */
    public function end( $gfx :Graphics ) :void
    {
      $gfx.endFill();
    }

    /**
     *  Convert a number from Degrees to Radians.
     *  @param  d   degrees (45°, 90°)
     *  @return     radians (3.14..., 1.57...)
     */
    private function degreesToRadians( d :Number ) :Number
    {
      return d * ( Math.PI / 180 );
    }
  }
}


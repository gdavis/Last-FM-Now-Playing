
package com.factorylabs.orange.core.display.fills
{
  import com.factorylabs.orange.core.display.graphics.IGraphic;

  import flash.display.Graphics;
  import flash.geom.Matrix;

  /**
   * GradientFill applies properties for rendering a gradient within a Graphic.
   *
   * <p>For a description of the built in <code>Graphics.beginGradientFill()</code> method see <code><a href="http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/Graphics.html#beginGradientFill()">beginGradientFill</a></code>.</p>
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
   * TODO: Can we substitue the Arrays for Vectors and get better performance?
   * TODO: The validate method isn't really testable and it should be. There's a better way – MK.
   */
  public class GradientFill
    implements IFill
  {
    /**
     * @private
     */
    protected var _rotation       :Number;

    /**
     * @private
     */
    protected var _colors       :Array;

    /**
     * @private
     */
    protected var _alphas       :Array;

    /**
     * @private
     */
    protected var _ratios       :Array;

    /**
     * @private
     */
    protected var _type         :String;

    /**
     * @private
     */
    protected var _spreadMethod     :String;

    /**
     * @private
     */
    protected var _interpolationMethod  :String;

    /**
     * @private
     */
    protected var _focalPointRatio    :Number;

    /**
     * The rotation angle for the gradient.
     */
    public function get rotation() :Number { return _rotation; }
    public function set rotation( $rotation : Number ) : void
    {
      _rotation = $rotation;
    }

    /**
     * The <code>Array</code> of colors in the gradient.
     */
    public function get colors() :Array { return _colors; }
    public function set colors( $colors :Array ) :void
    {
      _colors = $colors;
    }

    /**
     * The <code>Array</code> of alphas in the gradient.
     */
    public function get alphas() :Array { return _alphas; }
    public function set alphas( $alphas :Array ) :void
    {
      _alphas = $alphas;
    }

    /**
     * The <code>Array</code> of ratios in the gradient.
     */
    public function get ratios() :Array { return _ratios; }
    public function set ratios( $ratios :Array ) :void
    {
      _ratios = $ratios;
    }

    /**
     * The <code>flash.display.GradientType</code> in the gradient.
     */
    public function get type() :String { return _type; }
    public function set type( $type :String ) :void
    {
      _type = $type;
    }

    /**
     * The <code>flash.display.SpreadMethod</code> in the gradient.
     */
    public function get spreadMethod() :String { return _spreadMethod; }
    public function set spreadMethod( $spreadMethod :String ) :void
    {
      _spreadMethod = $spreadMethod;
    }

    /**
     * The <code>flash.display.InterpolationMethod</code> in the gradient.
     */
    public function get interpolationMethod() :String { return _interpolationMethod; }
    public function set interpolationMethod( $interpolationMethod :String ) :void
    {
      _interpolationMethod = $interpolationMethod;
    }

    /**
     * The focal point of the gradient.
     */
    public function get focalPointRatio() :Number { return _focalPointRatio; }
    public function set focalPointRatio( $focalPointRatio :Number ) :void
    {
      _focalPointRatio = $focalPointRatio;
    }

    /**
     * Constructs a new gradient fill.
     * @param $rotation       The degree amount used in the <code>Matrix.createGradientBox</code> to rotate the gradient.
     * @param $colors       An array (up to 15) of RGB hexadecimal color values to be used in the gradient. For each color, be sure to specify a corresponding value in the alphas and ratios parameters. If <code>null</code> the array <code>[ 0xffffff, 0x000000 ]</code> will be used.
     * @param $alphas       An array of alpha values for the corresponding colors in the colors array; valid values are 0 to 1. If <code>null</code> the array <code>[ 1, 1 ]</code> will be used.
     * @param $ratios       An array of color distribution ratios; valid values are 0 to 255. This value defines the percentage of the width where the color is sampled at 100%. The value 0 represents the left-hand position in the gradient box, and 255 represents the right-hand position in the gradient box. If <code>null</code> the array <code>[ 0, 255 ]</code> will be used.
     * @param $type         A value from the <code>GradientType</code> class that specifies which gradient type to use: <code>GradientType.LINEAR</code> or <code>GradientType.RADIAL</code>.
     * @param $spreadMethod     A value from the <code>SpreadMethod</code> class that specifies which spread method to use, either: <code>SpreadMethod.PAD</code>, <code>SpreadMethod.REFLECT</code>, or <code>SpreadMethod.REPEAT</code>.
     * @param $interpolationMethod  A value from the <code>InterpolationMethod</code> class that specifies which value to use: <code>InterpolationMethod.linearRGB</code> or <code>InterpolationMethod.RGB</code>.
     * @param $focalPointRatio    A number that controls the location of the focal point of the gradient. 0 means that the focal point is in the center. 1 means that the focal point is at one border of the gradient circle. -1 means that the focal point is at the other border of the gradient circle. A value less than -1 or greater than 1 is rounded to -1 or 1.
     *
     * @example The following code creates a Gradient Fill.
     * <listing version="3.0" >
     * var gf :GradientFill = new GradientFill( 90, [ 0xffffff, 0xbcbec0, 0xd1d3d4], [ 1, 1, 0 ], [ 0, 127, 255 ], GradientType.LINEAR, SpreadMethod.PAD, InterpolationMethod.RGB, 0 );
     * </listing>
     */
    public function GradientFill( $rotation :Number = 0, $colors :Array = null, $alphas :Array = null, $ratios :Array = null, $type :String = 'linear', $spreadMethod :String = 'pad', $interpolationMethod :String = 'rgb', $focalPointRatio :Number = 0 )
    {
      _rotation = $rotation;
      _colors = ( $colors != null ) ? $colors : [ 0xffffff, 0x000000 ];
      _alphas = ( $alphas != null ) ? $alphas : [ 1, 1 ];
      _ratios = ( $ratios != null ) ? $ratios : [ 0, 255 ];
      _type = $type;
      _spreadMethod = $spreadMethod;
      _interpolationMethod = $interpolationMethod;
      _focalPointRatio = $focalPointRatio;
    }

    /**
     * @return  The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.fills.GradientFill';
    }

    /**
     * @inheritDoc
     */
    public function begin( $gfx :Graphics, $igfx :IGraphic ) :void
    {
      validate();
      var matrix :Matrix = new Matrix();
      matrix.createGradientBox( $igfx.width, $igfx.height, degreesToRadians( _rotation ), $igfx.x, $igfx.y );
      $gfx.beginGradientFill( _type, _colors, _alphas, _ratios, matrix, _spreadMethod, _interpolationMethod, _focalPointRatio );
    }

    /**
     * @inheritDoc
     */
    public function end( $gfx :Graphics ) :void
    {
      $gfx.endFill();
    }

    /**
     * Validates the arrays to ensure all have the same length.
     * @throws  ArgumentError <code>ArgumentError</code> The arrays for colors, alphas, ratios must all be the same length.
     */
    private function validate() :void
    {
      var cl :Number = _colors.length;
      var rl :Number = _ratios.length;
      var al :Number = _alphas.length;

      if( cl != al || cl != rl  || al != cl || al != rl )
        throw new ArgumentError( this.toString() + ' : has unequal values for the Arrays: colors, alphas, ratios.' );
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


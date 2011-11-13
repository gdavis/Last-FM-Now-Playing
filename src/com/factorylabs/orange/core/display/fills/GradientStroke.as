
package com.factorylabs.orange.core.display.fills
{
  import com.factorylabs.orange.core.display.graphics.IGraphic;

  import flash.display.Graphics;
  import flash.geom.Matrix;

  /**
   * GradientStroke applies properties for rendering a gradient stroke on a Graphic.
   *
   * <p>For a description of the built in <code>Graphics.lineGradientStyle()</code> method see <code><a href="http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/Graphics.html#lineGradientStyle()">lineGradientStyle</a></code>.</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Jun 2, 2008
   */
  public class GradientStroke
    implements IFill
  {
    /**
     * @private
     */
    protected var _gradientFill :GradientFill;

    /**
     * @private
     */
    protected var _solidStroke  :SolidStroke;

    /**
     * The stroke's <code>GradientFill</code> properties.
     */
    public function get gradientFill() :GradientFill { return _gradientFill; }
    public function set gradientFill( $gradientFill :GradientFill ) :void
    {
      _gradientFill = $gradientFill;
    }

    /**
     * The gradient strokes, line style properties.
     */
    public function get solidStroke() :SolidStroke { return _solidStroke; }
    public function set solidStroke( $solidStroke :SolidStroke ) :void
    {
      _solidStroke = $solidStroke;
    }

    /**
     * Constructs a new GradientStroke.
     * @param $gradientFill   @see GradientFill
     * @param $solidStroke    @see SolidStroke
     *
     * @example The following code creates a gradient line.
     * <listing version="3.0" >
     * var gf :GradientFill = new GradientFill( 0, [ 0xffffff, 0x333333 ] );
     * var ss :SolidStroke = new SolidStroke( 0xcccccc, 1, 3, true );
     * var gs :GradientStroke = new GradientStroke( gf, ss );
     * </listing>
     */
    public function GradientStroke( $gradientFill :GradientFill, $solidStroke :SolidStroke )
    {
      _gradientFill = $gradientFill;
      _solidStroke = $solidStroke;
    }

    /**
     * @return  The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.fills.GradientStroke';
    }

    /**
     * @inheritDoc
     */
    public function begin( $gfx :Graphics, $igfx :IGraphic ) :void
    {
      var matrix : Matrix = new Matrix();
      matrix.createGradientBox( $igfx.width, $igfx.height, degreesToRadians( _gradientFill.rotation ), $igfx.x, $igfx.y );
      _solidStroke.begin( $gfx, $igfx );
      $gfx.lineGradientStyle( _gradientFill.type, _gradientFill.colors, _gradientFill.alphas, _gradientFill.ratios, matrix, _gradientFill.spreadMethod, _gradientFill.interpolationMethod, _gradientFill.focalPointRatio);
    }

    /**
     * @inheritDoc
     */
    public function end( $gfx :Graphics ) :void
    {
      $gfx.moveTo( 0, 0 );
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


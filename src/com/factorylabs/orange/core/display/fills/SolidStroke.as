
package com.factorylabs.orange.core.display.fills
{
  import com.factorylabs.orange.core.display.graphics.IGraphic;

  import flash.display.Graphics;

  /**
   * SolidStroke applies properties for rendering a stroke on a Graphic.
   *
   * <p>For a description of the built in <code>Graphics.lineStyle()</code> method see <code><a href="http://help.adobe.com/en_US/AS3LCR/Flash_10.0/flash/display/Graphics.html#lineStyle()">lineStyle</a></code>.</p>
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
  public class SolidStroke
    implements IFill
  {
    /**
     * @private
     */
    protected var _color    :uint;

    /**
     * @private
     */
    protected var _alpha    :Number;

    /**
     * @private
     */
    protected var _thickness  :uint;

    /**
     * @private
     */
    protected var _pixelHinting :Boolean;

    /**
     * @private
     */
    protected var _scaleMode  :String;

    /**
     * @private
     */
    protected var _caps     :String;

    /**
     * @private
     */
    protected var _joints   :String;

    /**
     * @private
     */
    protected var _miterLimit :Number;

    /**
     * Get or set the color used in a <code>SolidStroke</code>.
     */
    public function get color() :uint { return _color; }
    public function set color( $color :uint ) :void
    {
      _color = $color;
    }

    /**
     * Get or set the opacity used in a <code>SolidStroke</code>.
     */
    public function get alpha() :Number { return _alpha; }
    public function set alpha( $alpha :Number ) :void
    {
      _alpha = $alpha;
    }

    /**
     * Get or set the stroke's thickness.
     */
    public function get thickness() :uint { return _thickness; }
    public function set thickness( $thickness :uint ) :void
    {
      _thickness = $thickness;
    }

    /**
     * * Get or set the value of whether to snap the stroke to full pixels.
     */
    public function get pixelHinting() :Boolean { return _pixelHinting; }
    public function set pixelHinting( $pixelHinting :Boolean ) :void
    {
      _pixelHinting = $pixelHinting;
    }

    /**
     * * Get or set the <code>flash.display.LineScaleMode</code> used on the stroke.
     */
    public function get scaleMode() :String { return _scaleMode; }
    public function set scaleMode( $scaleMode :String ) :void
    {
      _scaleMode = $scaleMode;
    }

    /**
     * Get or set the <code>flash.display.CapsStyle</code> used on the stroke.
     */
    public function get caps() :String { return _caps; }
    public function set caps( $caps :String ) :void
    {
      _caps = $caps;
    }

    /**
     * Get or set the <code>flash.display.JointStyle</code> used on the stroke.
     */
    public function get joints() :String { return _joints; }
    public function set joints( $joints :String ) :void
    {
      _joints = $joints;
    }

    /**
     * Get or set the limit of the miter used on the stroke.
     */
    public function get miterLimit() :Number { return _miterLimit; }
    public function set miterLimit( $miterLimit :Number ) :void
    {
      _miterLimit = $miterLimit;
    }

    /**
     * Constructs a solid stroke.
     * @param $color  A hexadecimal color value of the fill.
     * @param $alpha  A number that indicates the alpha value of the color of the fill; valid values are 0 to 1.
     * @param $thickness    An integer that indicates the thickness of the line in points; valid values are 0 to 255. The value 0 indicates hairline thickness; the maximum thickness is 255.
     * @param $pixelHinting   A Boolean value that specifies whether to hint strokes to full pixels. This affects both the position of anchors of a curve and the line stroke size itself. With pixelHinting set to true, Flash Player hints line widths to full pixel widths. With pixelHinting set to false, disjoints can appear for curves and straight lines.
     * @param $scaleMode    A value from the <code>LineScaleMode</code> class that specifies which scale mode to use on a stroke. Valid values are: <code>LineScaleMode.NORMAL</code>, <code>LineScaleMode.VERTICAL</code>, <code>LineScaleMode.HORIZONTAL</code>.
     * @param $caps       A value from the <code>CapsStyle</code> class that specifies the type of caps at the end of lines. Valid values are: <code> CapsStyle.NONE</code>, <code>CapsStyle.ROUND</code>, <code>CapsStyle.SQUARE</code>.
     * @param $joints     A value from the <code>JointStyle</code> class that specifies the type of joint appearance used at angles. Valid values are: <code>JointStyle.BEVEL</code>, <code>JointStyle.MITER</code>, and <code>JointStyle.ROUND</code>.
     * @param $miterLimit   A number that indicates the limit at which a miter is cut off. Valid values range from 1 to 255. This value is only used if the <code>jointStyle</code> is set to "miter". The <code>miterLimit</code> value represents the length that a miter can extend beyond the point at which the lines meet to form a joint. The value expresses a factor of the line <code>thickness</code>. For example, with a <code>miterLimit</code> factor of 2.5 and a <code>thickness</code> of 10 pixels, the miter is cut off at 25 pixels.
     *
     * @example The following code creates a light grey 3pt stroke.
     * <listing version="3.0" >
     * var ss :SolidStroke = new SolidStroke( 0xcccccc, 1, 3, true, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.MITER, 4 );
     * </listing>
     */
    public function SolidStroke( $color :uint = 0xff00ff, $alpha :Number = 1, $thickness :uint = 1, $pixelHinting :Boolean = false, $scaleMode :String = 'normal', $caps :String = 'none', $joints :String = 'miter', $miterLimit :Number = 3 )
    {
      _color = $color;
      _alpha = $alpha;
      _thickness = $thickness;
      _pixelHinting = $pixelHinting;
      _scaleMode = $scaleMode;
      _caps = $caps;
      _joints = $joints;
      _miterLimit = $miterLimit;
    }

    /**
     * @return  The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.fills.SolidStroke';
    }

    /**
     * @inheritDoc
     */
    public function begin( $gfx :Graphics, $igfx :IGraphic ) :void
    {
      $gfx.lineStyle( _thickness, _color, _alpha, _pixelHinting, _scaleMode, _caps, _joints, _miterLimit );
      $igfx = null;
    }

    /**
     * @inheritDoc
     */
    public function end( $gfx :Graphics ) :void
    {
      $gfx.moveTo( 0, 0 );
    }
  }
}


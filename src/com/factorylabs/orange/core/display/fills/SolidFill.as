
package com.factorylabs.orange.core.display.fills
{
  import com.factorylabs.orange.core.display.graphics.IGraphic;

  import flash.display.Graphics;

  /**
   * SolidFill applies properties for rendering a color within a class that implements <code>IGraphic</code>.
   *
   * <p>For a description of the built in <code>Graphics.beginFill()</code> method see <code><a href="http://help.adobe.com/en_US/AS3LCR/Flash_10.0/index.html">beginFill</a></code>.</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Dec 3, 2009
   */
  public class SolidFill
    implements IFill
  {
    /**
     * @private
     */
    protected var _color  :uint;

    /**
     * @private
     */
    protected var _alpha  :Number;

    /**
     * Get or set the color used in a <code>SolidFill</code>.
     */
    public function get color() :uint { return _color; }
    public function set color( $color :uint ) :void
    {
      _color = $color;
    }

    /**
     * Get or set the opacity used in a <code>SolidFill</code>.
     */
    public function get alpha() :Number { return _alpha; }
    public function set alpha( $alpha :Number ) :void
    {
      _alpha = $alpha;
    }

    /**
     * Constructs a new solid fill.
     * @param $color  A hexadecimal color value of the fill.
     * @param $alpha  A number that indicates the alpha value of the color of the fill; valid values are 0 to 1.
     * @example The following code creates a grey solid fill with 80% opacity.
     * <listing version="3.0" >
     * var sf :SolidFill = new SolidFill( 0x666666, .8 );
     * </listing>
     */
    public function SolidFill( $color :uint = 0xff00ff, $alpha :Number = 1 )
    {
      _color = $color;
      _alpha = $alpha;
    }

    /**
     * @return  The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.fills.SolidFill';
    }

    /**
     * @inheritDoc
     */
    public function begin( $gfx :Graphics, $igfx :IGraphic ) :void
    {
      $gfx.beginFill( _color, _alpha );
      $igfx = null;
    }

    /**
     * @inheritDoc
     */
    public function end( $gfx :Graphics ) :void
    {
      $gfx.endFill();
    }
  }
}



package com.factorylabs.orange.core.display.graphics
{
  import com.factorylabs.orange.core.display.fills.IFill;

  import flash.display.Graphics;

  /**
   * Draws a rounded rectangle shape with all values for individual corners equal.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: June 3, 2008
   */
  public class FRectRound
    extends Graphic
  {
    /**
     * @private
     */
    protected var _cornerWidth  :Number;

    /**
     * @private
     */
    protected var _cornerHeight :Number;

    /**
     * Ellipse width for drawing a corner radius.
     */
    public function get cornerWidth() :Number
    {
      return _cornerWidth;
    }
    public function set cornerWidth( $cornerWidth :Number ) :void
    {
      _cornerWidth = $cornerWidth;
      if( _autoRedraw )
        redraw();
    }

    /**
     * Ellipse height for drawing a corner radius.
     */
    public function get cornerHeight() :Number
    {
      return _cornerHeight;
    }
    public function set cornerHeight( $cornerHeight :Number ) :void
    {
      _cornerHeight = $cornerHeight;
      if( _autoRedraw )
        redraw();
    }

    /**
     * Constructs and draws a rounded rectangle shape with equal values for all individual corners.
     * @param $gfx      Reference to the <code>shape.graphics</code> where the shape will be drawn into.
     * @param $x      A number indicating the horizontal position relative to the registration point of the parent display object.
     * @param $y      A number indicating the vertical position relative to the registration point of the parent display object.
     * @param $width    The <code>width</code> of the shape.
     * @param $height   The <code>height</code> of the shape.
     * @param $fill     Fill or line style to apply the shape.
     * @param $cornerWidth  The <code>width</code> of the ellipse used to draw the rounded corners.
     * @param $cornerHeight The <code>height</code> of the ellipse used to draw the rounded corners (in pixels). If no value is specified, the default value matches that provided for the <code>ellipseWidth</code> parameter.
     * @param $center   Whether to draw the shape from a center registration.
     * @param $autoRedraw Determines if the graphic should auto redraw when a setter is called.
     *
     * @example The following code creates a rounded rectangle.
     * <listing version="3.0" >
     * var sf :SolidFill = new SolidFill( 0x666666, .8 );
     * var c1 :FRectRound = new FRectRound( _gfx.graphics, 0, 110, 200, 100, sf, 10 );
     * </listing>
     */
    public function FRectRound( $gfx :Graphics, $x :Number = 0, $y :Number = 0, $width :Number = 10, $height :Number = 10, $fill :IFill = null, $cornerWidth :Number = 0, $cornerHeight :Number = NaN, $center :Boolean = false, $autoRedraw :Boolean = false )
    {
      super( $gfx, $x, $y, $width, $height, $fill, $center, $autoRedraw );
      _cornerWidth = $cornerWidth;
      _cornerHeight = $cornerHeight;
      internalDraw();
    }

    /**
     * @return  The string equivalent of this class.
     */
    override public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.graphics.FRectRound';
    }

    /**
     * Draws the rounded rectangle.
     * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/index.html drawRoundRect()
     */
    override protected function drawGraphic() :void
    {
      _gfx.drawRoundRect( _x, _y, _width, _height, _cornerWidth, _cornerHeight );
    }
  }
}


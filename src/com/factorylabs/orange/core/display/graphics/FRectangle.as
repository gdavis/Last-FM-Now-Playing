
package com.factorylabs.orange.core.display.graphics
{
  import com.factorylabs.orange.core.display.fills.IFill;
  import flash.display.Graphics;

  /**
   * Draws a rectangle shape.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Jun 3, 2008
   */
  public class FRectangle
    extends Graphic
  {
    /**
     * Constructs and draws a rectangle shape.
     * @param $gfx      Reference to the <code>shape.graphics</code> where the shape will be drawn into.
     * @param $x      A number indicating the horizontal position relative to the registration point of the parent display object.
     * @param $y      A number indicating the vertical position relative to the registration point of the parent display object.
     * @param $width    The <code>width</code> of the shape.
     * @param $height   The <code>height</code> of the shape.
     * @param $fill     Fill or line style to apply to the shape.
     * @param $center   Whether to draw the shape from a center registration.
     * @param $autoRedraw Determines if the graphic should auto redraw when a setter is called.
     *
     * @example The following code creates a rectangle.
     * <listing version="3.0" >
     * var sf :SolidFill = new SolidFill( 0x666666, .8 );
     * var r1 :FRectangle = new FRectangle( _gfx.graphics, 0, 0, 200, 100, sf );
     * </listing>
     */
    public function FRectangle( $gfx :Graphics = null, $x :Number = 0, $y :Number = 0, $width :Number = 10, $height :Number = 10, $fill :IFill = null, $center :Boolean = false, $autoRedraw :Boolean = false )
    {
      super( $gfx, $x, $y, $width, $height, $fill, $center, $autoRedraw );
      internalDraw();
    }

    /**
     * @return  The string equivalent of this class.
     */
    override public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.graphics.FRectangle';
    }

    /**
     * Draws the Rectangle.
     * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/index.html#drawRect()
     */
    override protected function drawGraphic() : void
    {
      _gfx.drawRect( _x, _y, _width, _height );
    }
  }
}


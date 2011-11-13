
package com.factorylabs.orange.core.display.graphics
{
  import com.factorylabs.orange.core.display.fills.IFill;

  import flash.display.Graphics;

  /**
   * Draws a rounded rectangle shape with an option to apply different rounding values for individual corners.
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
  public class FRectRoundComplex
    extends Graphic
  {
    /**
     * @private
     */
    protected var _topLeft    :Number;

    /**
     * @private
     */
    protected var _topRight   :Number;

    /**
     * @private
     */
    protected var _bottomLeft :Number;

    /**
     * @private
     */
    protected var _bottomRight  :Number;

    /**
     * The top left corner value.
     */
    public function get topLeft() :Number
    {
      return _topLeft;
    }
    public function set topLeft( $topLeft :Number ) :void
    {
      _topLeft = $topLeft;
      if( _autoRedraw )
        redraw();
    }

    /**
     * The top right corner value.
     */
    public function get topRight() :Number
    {
      return _topRight;
    }
    public function set topRight( $topRight :Number ) :void
    {
      _topRight = $topRight;
      if( _autoRedraw )
        redraw();
    }

    /**
     * The bottom left corner value.
     */
    public function get bottomLeft() :Number
    {
      return _bottomLeft;
    }
    public function set bottomLeft( $bottomLeft :Number ) :void
    {
      _bottomLeft = $bottomLeft;
      if( _autoRedraw )
        redraw();
    }

    /**
     * The bottom right corner value.
     */
    public function get bottomRight() :Number
    {
      return _bottomRight;
    }
    public function set bottomRight( $bottomRight :Number ) :void
    {
      _bottomRight = $bottomRight;
      if( _autoRedraw )
        redraw();
    }

    /**
     * Constructs and draws a rounded rectangle shape with an option to apply different values for individual corners.
     * @param $gfx      Reference to the <code>shape.graphics</code> where the shape will be drawn into.
     * @param $x      A number indicating the horizontal position relative to the registration point of the parent display object.
     * @param $y      A number indicating the vertical position relative to the registration point of the parent display object.
     * @param $width    The <code>width</code> of the shape.
     * @param $height   The <code>height</code> of the shape.
     * @param $fill     Fill or line style to apply the shape.
     * @param $tl     The top left corner value.
     * @param $tr     The top right corner value.
     * @param $bl     The bottom left corner value.
     * @param $br     The bottom right corner value.
     * @param $center   Whether to draw the shape from a center registration.
     * @param $autoRedraw Determines if the graphic should auto redraw when a setter is called.
     *
     * @example The following code creates a complex rounded rectangle.
     * <listing version="3.0" >
     * var sf :SolidFill = new SolidFill( 0x666666, .8 );
     * var r1 :FRectRoundComplex = new FRectRoundComplex( _gfx.graphics, 0, 0, 200, 100, sf, 10, 10, 0, 0 );
     * </listing>
     */
    public function FRectRoundComplex( $gfx :Graphics, $x :Number = 0, $y :Number = 0, $width :Number = 10, $height :Number = 10, $fill :IFill = null, $tl :Number = 0, $tr :Number = 0, $bl :Number = 0, $br :Number = 0, $center :Boolean = false, $autoRedraw :Boolean = false )
    {
      super( $gfx, $x, $y, $width, $height, $fill, $center, $autoRedraw );
      _topLeft = $tl;
      _topRight = $tr;
      _bottomLeft = $bl;
      _bottomRight = $br;
      internalDraw();
    }

    /**
     * @return  the string equivalent of this class.
     */
    override public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.graphics.FRectRoundComplex';
    }

    /**
     * Draws the complex rounded rectangle.
     * @see http://help.adobe.com/en_US/AS3LCR/Flash_10.0/index.html drawRoundRectComplex()
     */
    override protected function drawGraphic() :void
    {
      _gfx.drawRoundRectComplex( _x, _y, _width, _height, _topLeft, _topRight, _bottomLeft, _bottomRight );
    }
  }
}


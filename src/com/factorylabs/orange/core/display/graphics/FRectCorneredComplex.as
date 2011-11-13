
package com.factorylabs.orange.core.display.graphics
{
  import com.factorylabs.orange.core.display.fills.IFill;
  import flash.display.Graphics;

  /**
   * Draws a cornered rectangle shape with an option to apply different values for individual corners.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Jun 4, 2008
   */
  public class FRectCorneredComplex
    extends FRectRoundComplex
  {
    /**
     * Constructs and draws a cornered rectangle shape with an option to apply different values for individual corners.
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
     * @example The following code creates a complex cornered rectangle.
     * <listing version="3.0" >
     * var sf :SolidFill = new SolidFill( 0x666666, .8 );
     * var r1 :FRectCorneredComplex = new FRectCorneredComplex( _gfx.graphics, 0, 0, 200, 100, sf, 10, 10, 0, 0 );
     * </listing>
     */
    public function FRectCorneredComplex( $gfx :Graphics, $x :Number = 0, $y :Number = 0, $width :Number = 10, $height :Number = 10, $fill :IFill = null, $tl :Number = 0, $tr :Number = 0, $bl :Number = 0, $br :Number = 0, $center :Boolean = false, $autoRedraw :Boolean = false )
    {
      super( $gfx, $x, $y, $width, $height, $fill, $tl, $tr, $bl, $br, $center, $autoRedraw );
    }

    /**
     * @return  The string equivalent of this class.
     */
    override public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.graphics.FRectCorneredComplex';
    }

    /**
     * Draws the complex cornered rectangle.
     * <p>Conditional check ensures each of the corner radiuses is not greater than either a minimum width or height value.</p>
     */
    override protected function drawGraphic() : void
    {
      var minsize :Number = Math.min( _width, _height ) * .5;

      if( _topLeft > minsize )
        _topLeft = minsize;

      if( _topRight > minsize )
        _topRight = minsize;

      if( _bottomLeft > minsize )
        _bottomLeft = minsize;

      if( _bottomRight > minsize )
        _bottomRight = minsize;

      _gfx.moveTo( 0, 0 );
      _gfx.moveTo( x + _topLeft, _y );
      _gfx.lineTo( x + _width - _topRight, _y );
      _gfx.lineTo( x + _width, _y + _topRight );
      _gfx.lineTo( x + _width, _y + _height - _bottomRight );
      _gfx.lineTo( x + _width - _bottomRight, _y + _height );
      _gfx.lineTo( x + _bottomLeft, _y + _height );
      _gfx.lineTo( x, _y + _height - _bottomLeft );
      _gfx.lineTo( x, _y + _topLeft );
      _gfx.lineTo( x + _topLeft, _y );
    }
  }
}


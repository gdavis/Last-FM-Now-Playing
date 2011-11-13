
package com.factorylabs.orange.core.display.graphics
{
  import com.factorylabs.orange.core.display.fills.IFill;
  import flash.display.Graphics;

  /**
   * Draws a square shape.
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
  public class FSquare
    extends FRectangle
  {
    /**
     * @private
     */
    protected var _size :Number;

    /**
     * Calls <code>set size</code> to keep the <code>width</code> and <code>height</code> equal.
     * @inheritDoc
     */
    override public function set width( $width :Number ) :void
    {
      size = $width;
    }

    /**
     * Calls <code>set size</code> to keep the <code>width</code> and <code>height</code> equal.
     * @inheritDoc
     */
    override public function set height( $height :Number ) :void
    {
      size = $height;
    }

    /**
     * Sets both the <code>width</code> and <code>height</code> equal.
     */
    public function get size() :Number
    {
      return _size;
    }
    public function set size( $size :Number ) :void
    {
      _size = $size;
      _width = $size;
      _height = $size;
      if( _autoRedraw )
        redraw();
    }

    /**
     * Constructs and draws a square shape.
     * @param $gfx      Reference to the <code>shape.graphics</code> where the shape will be drawn into.
     * @param $x      A number indicating the horizontal position relative to the registration point of the parent display object.
     * @param $y      A number indicating the vertical position relative to the registration point of the parent display object.
     * @param $size     The <code>width</code> and <code>height</code> of the shape.
     * @param $fill     Fill or line style to apply the shape.
     * @param $center   Whether to draw the shape from a center registration.
     * @param $autoRedraw Determines if the graphic should auto redraw when a setter is called.
     *
     * @example The following code creates a square.
     * <listing version="3.0" >
     * var sf : SolidFill = new SolidFill( 0x666666, .8 );
     * var s1 : FSquare = new FSquare( _gfx.graphics, 0, 110, 200, sf );
     * </listing>
     */
    public function FSquare( $gfx :Graphics = null, $x :Number = 0, $y :Number = 0, $size :Number = 10, $fill :IFill = null, $center :Boolean = false, $autoRedraw :Boolean = false )
    {
      super( $gfx, $x, $y, $size, $size, $fill, $center, $autoRedraw );
      _size = $size;
      internalDraw();
    }

    /**
     * @return  The string equivalent of this class.
     */
    override public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.graphics.FSquare';
    }
  }
}


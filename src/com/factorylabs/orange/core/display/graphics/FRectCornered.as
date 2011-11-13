
package com.factorylabs.orange.core.display.graphics
{
  import com.factorylabs.orange.core.display.fills.IFill;

  import flash.display.Graphics;

  /**
   * Draws a cornered rectangle shape with all values for individual corners equal.
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
  public class FRectCornered
    extends FRectCorneredComplex
  {
    /**
     * @private
     */
    protected var _corner   :Number;

    /**
     * @inheritDoc
     */
    override public function set topLeft( $topLeft :Number ) :void
    {
      corner = $topLeft;
    }

    /**
     * @inheritDoc
     */
    override public function set topRight( $topRight :Number ) :void
    {
      corner = $topRight;
    }

    /**
     * @inheritDoc
     */
    override public function set bottomLeft( $bottomLeft :Number ) :void
    {
      corner = $bottomLeft;
    }

    /**
     * @inheritDoc
     */
    override public function set bottomRight( $bottomRight :Number ) :void
    {
      corner = $bottomRight;
    }

    /**
     * Sets all corners equal.
     */
    public function get corner() :Number { return _corner; }
    public function set corner( $corner :Number ) :void
    {
      _corner = $corner;
      _topLeft = $corner;
      _topRight = $corner;
      _bottomLeft = $corner;
      _bottomRight = $corner;
      if( _autoRedraw )
        redraw();
    }

    /**
     * Constructs and draws a cornered rectangle shape with equal values for all individual corners.
     * @param $gfx      Reference to the <code>shape.graphics</code> where the shape will be drawn into.
     * @param $x      A number indicating the horizontal position relative to the registration point of the parent display object.
     * @param $y      A number indicating the vertical position relative to the registration point of the parent display object.
     * @param $width    The <code>width</code> of the shape.
     * @param $height   The <code>height</code> of the shape.
     * @param $fill     Fill or line style to apply the shape.
     * @param $cv     The corner value for all sides of the rectangle.
     * @param $center   Whether to draw the shape from a center registration.
     * @param $autoRedraw Determines if the graphic should auto redraw when a setter is called.
     *
     * @example The following code creates a cornered rectangle.
     * <listing version="3.0" >
     * var sf :SolidFill = new SolidFill( 0x666666, .8 );
     * var c1 :FRectCornered = new FRectCornered( _gfx.graphics, 0, 110, 200, 100, sf, 10 );
     * </listing>
     */
    public function FRectCornered( $gfx :Graphics, $x :Number = 0, $y :Number = 0, $width :Number = 10, $height :Number = 10, $fill :IFill = null, $cv :Number = 0, $center :Boolean = false, $autoRedraw :Boolean = false )
    {
      super( $gfx, $x, $y, $width, $height, $fill, $cv, $cv, $cv, $cv, $center, $autoRedraw );
      _corner = $cv;
    }

    /**
     * @return  The string equivalent of this class.
     */
    override public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.graphics.FRectCornered';
    }
  }
}


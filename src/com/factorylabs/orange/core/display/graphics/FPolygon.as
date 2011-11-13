
package com.factorylabs.orange.core.display.graphics
{
  import com.factorylabs.orange.core.display.fills.IFill;

  import flash.display.Graphics;

  /**
   * Draws a polygon shape with a minimum of 3 sides.
   *
   * <p>Based on the drawing routines from <a href="http://www.formequalsfunction.com/downloads/drawmethods.html">form = function</a>.</p>
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
  public class FPolygon
    extends Graphic
  {
    /**
     * @private
     */
    protected var _sides  :uint;

    /**
     * @private
     */
    protected var _radius :Number;

    /**
     * @private
     */
    protected var _angle  :Number;

    /**
     * Calls <code>set radius</code> to keep the <code>width</code> and <code>height</code> equal.
     * @inheritDoc
     */
    override public function set width( $width :Number ) :void
    {
      radius = $width;
    }

    /**
     * Calls <code>set radius</code> to keep the <code>width</code> and <code>height</code> equal.
     * @inheritDoc
     */
    override public function set height( $height :Number ) :void
    {
      radius = $height;
    }

    /**
     * The number of sides used by the polygon.
     */
    public function get sides() :uint
    {
      return _sides;
    }
    public function set sides( $sides :uint ) :void
    {
      _sides = $sides;
      if( _autoRedraw )
        redraw();
    }

    /**
     * The radius of the polygon.
     */
    public function get radius() :Number
    {
      return _radius;
    }
    public function set radius( $radius :Number ) :void
    {
      _width = $radius;
      _height = $radius;
      _radius = $radius;
      if( _autoRedraw )
        redraw();
    }

    /**
     * The rotation angle of the shape.
     */
    public function get angle() :Number
    {
      return _angle;
    }
    public function set angle( $angle :Number ) :void
    {
      _angle = $angle;
      if( _autoRedraw )
        redraw();
    }

    /**
     * Constructs and draws a new polygon with a minimum of 3 sides.
     * @param $gfx      Reference to the <code>shape.graphics</code> where the shape will be drawn into.
     * @param $x      A number indicating the horizontal position relative to the registration point of the parent display object.
     * @param $y      A number indicating the vertical position relative to the registration point of the parent display object.
     * @param $sides    The number of sides for the polygon.
     * @param $radius   The of the polygon to draw.
     * @param $angle    Rotation angle of the polygon. Valid values are between 0 and 360.
     * @param $fill     Fill or line style to apply to the shape.
     * @param $center   Whether to draw the shape from a center registration.
     * @param $autoRedraw Determines if the graphic should auto redraw when a setter is called.
     *
     * @example The following code creates a 5 sided polygon.
     * <listing version="3.0" >
     * var sf :SolidFill = new SolidFill( 0x666666, .8 );
     * var p1 :FPolygon = new FPolygon( _gfx.graphics, 50, 0, 5, 50, 0, sf );
     * </listing>
     */
    public function FPolygon( $gfx : Graphics, $x :Number = 0, $y :Number = 0, $sides :uint = 3, $radius :Number = 5, $angle :Number = 0, $fill :IFill = null, $center :Boolean = false, $autoRedraw :Boolean = false )
    {
      super( $gfx, $x, $y, $radius * 2, $radius * 2, $fill, $center, $autoRedraw );
      _sides = $sides;
      _radius = $radius;
      _angle = $angle;
      internalDraw();
    }

    /**
     * @return  The string equivalent of this class.
     */
    override public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.graphics.FPolygon';
    }

    /**
     * Procedure for drawing a polygon.
     */
    override protected function drawGraphic() : void
    {
      _gfx.moveTo( 0, 0 );

      // calculate span of sides and start point.
      var step :Number = ( Math.PI * 2 ) / _sides;
      var startPoint :Number = ( _angle * ( Math.PI / 180 ) );

      // draw angles.
      _gfx.moveTo( x + ( Math.cos( startPoint ) * _radius ), y - ( Math.sin( startPoint ) * _radius ) );
      for ( var i : int = 1; i <= _sides ; i++ )
      {
        var dx :Number = x + Math.cos( startPoint + ( step * i ) ) * _radius;
        var dy :Number = y - Math.sin( startPoint + ( step * i ) ) * _radius;
        _gfx.lineTo( dx, dy );
      }
    }
  }
}


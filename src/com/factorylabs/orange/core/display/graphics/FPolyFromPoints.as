
package com.factorylabs.orange.core.display.graphics
{
  import com.factorylabs.orange.core.display.fills.IFill;

  import flash.display.Graphics;

  /**
   * Draws a polygon shape from a compound array of <code>x</code> and <code>y</code> coordinates.
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
   *
   * TODO: Willing to bet we can refactor this to use Vectors and the FP10 drawing API.. Let's run performance tests before we do though.
   */
  public class FPolyFromPoints
    extends Graphic
  {
    /**
     * @private
     */
    protected var _points :Array;

    /**
     * Not allowed since this is a drawing from a set of points.
     * @throws ArgumentError <code>ArgumentError</code> when trying to call the setter.
     */
    override public function set x( $x :Number ) :void
    {
      throw new ArgumentError( 'An invalid property assignment was attempted on ' + this.toString() + ' you should either reset the points property or adjust the container clip.' );
    }

    /**
     * Not allowed since this is a drawing from a set of points.
     * @throws ArgumentError <code>ArgumentError</code> when trying to call the setter.
     */
    override public function set y( $y :Number ) :void
    {
      throw new ArgumentError( 'An invalid property assignment was attempted on ' + this.toString() + ' you should either reset the points property or adjust the container clip.' );
    }

    /**
     * Not allowed since this is a drawing from a set of points.
     * @throws ArgumentError <code>ArgumentError</code> when trying to call the setter.
     */
    override public function set width( $width :Number ) :void
    {
      throw new ArgumentError( 'An invalid property assignment was attempted on ' + this.toString() + ' you should either reset the points property or adjust the container clip.' );
    }

    /**
     * Not allowed since this is a drawing from a set of points.
     * @throws ArgumentError <code>ArgumentError</code> when trying to call the setter.
     */
    override public function set height( $height :Number ) :void
    {
      throw new ArgumentError( 'An invalid property assignment was attempted on ' + this.toString() + ' you should either reset the points property or adjust the container clip.' );
    }

    /**
     * The compound array of coordinates.
     */
    public function get points() :Array
    {
      return _points;
    }
    public function set points( $points :Array ) :void
    {
      _points = $points;
      dimensions();
      if( _autoRedraw )
        redraw();
    }


    /**
     * Constructs and draws a polygon from a compound array.
     * @param $gfx      Reference to the <code>shape.graphics</code> where the shape will be drawn into.
     * @param $points   Compound array of x and y coordinate points.
     * @param $fill     Fill or line style to apply the shape.
     * @param $autoRedraw Determines if the graphic should auto redraw when a setter is called.
     *
     * @example The following code creates a polygon shape.
     * <listing version="3.0" >
     * var sf :SolidFill = new SolidFill( 0x666666, .8 );
     * var p1 :FPolyFromPoints = new FPolyFromPoints( _gfx.graphics, [ [0, 0], [0, 100], [100, 200], [ 350, 300] ], sf );
     * </listing>
     */
    public function FPolyFromPoints( $gfx :Graphics, $points :Array, $fill :IFill = null, $autoRedraw :Boolean = false )
    {
      super( $gfx, 0, 0, 10, 10, $fill, false, $autoRedraw );
      _points = $points;

      // override the dimensions from the array of points..
      dimensions();
      internalDraw();
    }

    /**
     * @return  The string equivalent of this class.
     */
    override public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.graphics.FPolyFromPoints';
    }

    /**
     * Procedure for drawing the shape from the array of coordinates.
     */
    override protected function drawGraphic() :void
    {
      // move to the first point.
      _gfx.moveTo( _points[ 0 ][ 0 ], _points[ 0 ][ 1 ] );

      var len :int = _points.length;

      // line to all of the points.
      for ( var i :int = 1; i < len; ++i )
        _gfx.lineTo( _points[ i ][ 0 ], _points[ i ][ 1 ] );

      _gfx.lineTo( _x, _y );
    }

    /**
     * Handles overriding the values for <code>x</code>, <code>y</code>, <code>width</code>, <code>height</code>.
     */
    private function dimensions() : void
    {
      var len :int = _points.length;

      // start with the first point.
      _x = _points[ 0 ][ 0 ];
      _y = _points[ 0 ][ 1 ];

      // coordinates to alter.
      var dx :Number = _x;
      var dy :Number = _y;

      // get the biggest x and y to get the width and height.
      var maxX :Number = points[ 0 ][ 0 ];
      var maxY :Number = points[ 0 ][ 1 ];

      // get the minimum and maximum x and y value from the array, this will be our xp, yp, maxX and maxY.
      for ( var i :int = 0; i < len; ++i )
      {
        dx = Math.min( dx, points[ i ][ 0 ] );
        dy = Math.min( dy, points[ i ][ 1 ] );
        maxX = Math.max( maxX, points[ i ][ 0 ] );
        maxY = Math.max( maxY, points[ i ][ 1 ] );
      }
      _width = maxX - dx;
      _height = maxY - dy;
    }
  }
}


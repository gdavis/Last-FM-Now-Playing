
package com.factorylabs.orange.core.display.graphics
{
  import com.factorylabs.orange.core.display.fills.IFill;

  import flash.display.Graphics;

  /**
   * Draws a dashed line (only supports line styles and not fills).
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
  public class FDashedLine
    extends Graphic
  {
    /**
     * @private
     */
    protected var _endX     :Number;

    /**
     * @private
     */
    protected var _endY     :Number;

    /**
     * @private
     */
    protected var _dashLength :Number;

    /**
     * @private
     */
    protected var _gapLength  :Number;

    /**
     * The final <code>x</code> position for the line.
     */
    public function get endX() :Number { return _endX; }
    public function set endX( $endX :Number ) :void
    {
      _endX = $endX;
      if( _autoRedraw )
        redraw();
    }

    /**
     * The final <code>y</code> position for the line.
     */
    public function get endY() :Number { return _endY; }
    public function set endY( $endY :Number ) :void
    {
      _endY = $endY;
      if( _autoRedraw )
        redraw();
    }

    /**
     * The length of each dash segment.
     */
    public function get dashLength() :Number { return _dashLength; }
    public function set dashLength( $dashLength :Number ) :void
    {
      _dashLength = $dashLength;
      if( _autoRedraw )
        redraw();
    }

    /**
     * The length of space between each segment.
     */
    public function get gapLength() :Number { return _gapLength; }
    public function set gapLength( $gapLength :Number ) :void
    {
      _gapLength = $gapLength;
      if( _autoRedraw )
        redraw();
    }

    /**
     * Not allowed since this is a drawing a distinct line.
     * @throws ArgumentError <code>ArgumentError</code> when trying to call the setter.
     */
    override public function set width( $width :Number ) :void
    {
      throw new ArgumentError( 'An invalid property assignment was attempted on ' + this.toString() + ' this is a line, change it\'s x and endX property and allow it to redraw for proper width.' );
    }

    /**
     * Not allowed since this is a drawing a distinct line.
     * @throws ArgumentError <code>ArgumentError</code> when trying to call the setter.
     */
    override public function set height( $height :Number ) :void
    {
      throw new ArgumentError( 'An invalid property assignment was attempted on ' + this.toString() + ' this is a line, change it\'s y and endY property and allow it to redraw for proper height.' );
    }

    /**
     * Not allowed since this is a drawing a distinct line.
     * @throws ArgumentError <code>ArgumentError</code> when trying to call the setter.
     */
    override public function set center( $center :Boolean ) :void
    {
      throw new ArgumentError( 'An invalid property assignment was attempted on ' + this.toString() + ' this is a line, change it\'s x/y and endX/endY property and allow it to redraw based on positions.' );
    }

    /**
     * Constructs and draws a new dashed line.
     * @param $gfx      Reference to the <code>shape.graphics</code> where the shape will be drawn into.
     * @param $x      Start <code>x</code> coordinate value to draw the shape.
     * @param $y      Start <code>y</code> coordinate value to draw the shape.
     * @param $endX     End <code>x</code> coordinate value to draw the shape.
     * @param $endY     End <code>y</code> coordinate value to draw the shape.
     * @param $dashLength Length of each dash segment.
     * @param $gapLength  Length of space between each dash segment.
     * @param $fill     Fill or line style to apply the shape.
     * @param $autoRedraw Determines if the graphic should auto redraw when a setter is called.
     *
     * @example The following code creates a dashed line.
     * <listing version="3.0" >
     * var ss :SolidStroke = new SolidStroke( 0xcccccc, 1, 3 );
     * var dl :FDashedLine = new FDashedLine( _gfx.graphics, 0, 0, 500, 0, 5, 5, ss );
     * </listing>
     */
    public function FDashedLine( $gfx :Graphics, $x :Number = 0, $y :Number = 0, $endX :Number = 10, $endY :Number = 0, $dashLength :Number = 1, $gapLength :Number = 1, $fill :IFill = null, $autoRedraw :Boolean = false )
    {
      super( $gfx, $x, $y, Math.abs( $x - $endX ), Math.abs( $y - $endY ), $fill, false, $autoRedraw );
      _endX = $endX;
      _endY = $endY;
      _dashLength = $dashLength;
      _gapLength = $gapLength;
      internalDraw();
    }

    /**
     * @return  The string equivalent of this class.
     */
    override public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.graphics.FDashedLine';
    }

    /**
     * Procedure for drawing a dashed line.
     */
    override protected function drawGraphic() : void
    {
      var deltax :Number = _endX - _x;
      var deltay :Number = _endY - _y;
      var seglength :Number = _dashLength + _gapLength;
      var mainDelta :Number = Math.sqrt( ( deltax * deltax ) + ( deltay * deltay ) );
      var segs :Number = Math.floor( Math.abs( mainDelta / seglength ) );
      var radians :Number = Math.atan2( deltay, deltax );
      var cx :Number = _x;
      var cy :Number = _y;

      deltax = Math.cos( radians ) * seglength;
      deltay = Math.sin( radians ) * seglength;

      for ( var n :int = 0; n < segs; n++ )
      {
        _gfx.moveTo( cx, cy );
        _gfx.lineTo( cx + Math.cos( radians ) * _dashLength, cy + Math.sin( radians ) * _dashLength );
        cx += deltax;
        cy += deltay;
      }

      _gfx.moveTo( cx, cy );
      mainDelta = Math.sqrt( ( _endX - cx ) * ( _endX - cx ) + ( _endY - cy ) * ( _endY - cy ) );

      if( mainDelta > dashLength )
        _gfx.lineTo( cx + Math.cos( radians ) * _dashLength, cy + Math.sin( radians ) * _dashLength );
      else if ( mainDelta > 0 )
        _gfx.lineTo( cx + Math.cos( radians ) * mainDelta, cy + Math.sin( radians ) * mainDelta );

      _gfx.moveTo( _endX, _endY );
    }
  }
}


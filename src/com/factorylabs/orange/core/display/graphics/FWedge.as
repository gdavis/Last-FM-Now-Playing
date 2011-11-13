
package com.factorylabs.orange.core.display.graphics
{
  import com.factorylabs.orange.core.display.fills.IFill;

  import flash.display.Graphics;

  /**
   * Draws a wedge shape.
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
   * @version   1.0.0 :: Jun 4, 2008
   */
  public class FWedge
    extends Graphic
  {
    /**
     * Property for drawing a wedge left to right.
     */
    public static const CLOCKWISE     :int = -1;

    /**
     * Property for drawing a wedge right to left.
     */
    public static const COUNTER_CLOCKWISE :int = 1;

    /**
     * @private
     */
    protected var _size :Number;

    /**
     * @private
     */
    protected var _arc      :Number;

    /**
     * @private
     */
    protected var _direction  :int;

    /**
     * @private
     */
    protected var _startAngle :Number;

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
     * The <code>arc</code> of the wedge.
     */
    public function get arc() :Number
    {
      return _arc;
    }
    public function set arc( $arc :Number ) :void
    {
      _arc = $arc;
      if( _autoRedraw )
        redraw();
    }

    /**
     * The <code>direction</code> the wedge will draw itself.
     */
    public function get direction() :int
    {
      return _direction;
    }
    public function set direction( $direction :int ) :void
    {
      _direction = $direction;
      if( _autoRedraw )
        redraw();
    }

    /**
     * The <code>angle</code> to start drawing the wedge.
     */
    public function get startAngle() :Number
    {
      return _startAngle;
    }
    public function set startAngle( $startAngle :Number ) :void
    {
      _startAngle = $startAngle;
      if( _autoRedraw )
        redraw();
    }

    /**
     * Constructs and draws a new wedge.
     * @param $gfx      Reference to the <code>shape.graphics</code> where the shape will be drawn into.
     * @param $x      A number indicating the horizontal position relative to the registration point of the parent display object.
     * @param $y      A number indicating the vertical position relative to the registration point of the parent display object.
     * @param $size     The <code>width</code> and <code>height</code> of the shape.
     * @param $arc      The sweep of the shape.
     * @param $fill     Fill or line style to apply the shape.
     * @param $direction  Whether to draw the wedge from left to right or right to left. Valid values are: <code>FWedge.CLOCKWISE</code>, <code>FWedge.COUNTER_CLOCKWISE</code>.
     * @param $startAngle The degree in which to start drawing the wedge shape.
     * @param $autoRedraw Determines if the graphic should auto redraw when a setter is called.
     *
     * @example The following code creates a wedge shape.
     * <listing version="3.0" >
     * var sf :SolidFill = new SolidFill( 0x666666, .8 );
     * var w1 :FWedge = new FWedge( _gfx.graphics, 200, 150, 50, 180, sf, FWedge.CLOCKWISE, 0 );
     * </listing>
     */
    public function FWedge( $gfx :Graphics, $x :Number = 0, $y :Number = 0, $size :Number = 10, $arc :Number = 180, $fill :IFill = null, $direction :int = 1, $startAngle :Number = 0, $autoRedraw :Boolean = false )
    {
      super( $gfx, $x, $y, $size, $size, $fill, false, $autoRedraw );
      _size = $size;
      _arc = $arc;
      _direction = $direction;
      _startAngle = $startAngle;
      internalDraw();
    }

    /**
     * @return  The string equivalent of this class.
     */
    override public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.graphics.FWedge';
    }

    /**
     * Procedure for drawing the wedge shape.
     */
    override protected function drawGraphic() :void
    {
      var ox :Number = _x;
      var oy :Number = _y;

      _gfx.moveTo( _x, _y );

      if( Math.abs( _arc ) > 360)
        _arc = 360;
      _arc *= _direction;

      var segs :Number = Math.ceil( Math.abs( _arc ) / 45 );
      var segAngle :Number = _arc / segs;
      var theta :Number = -( ( segAngle ) * ( Math.PI / 180 ) );
      var angle :Number = -( ( _startAngle ) * ( Math.PI / 180 ) );

      var ax :Number = _x + Math.cos( ( _startAngle ) * ( Math.PI / 180 ) ) * _size;
      var ay :Number = _y + Math.sin( -( _startAngle ) * ( Math.PI / 180 ) ) * _size;
      _gfx.lineTo( ax, ay );

      for( var i :int = 0; i < segs; ++i )
      {
        angle += theta;
        var angleMid :Number = angle - ( theta * .5 );
        var bx :Number = _x + Math.cos( angle ) * _size;
        var by :Number = _y + Math.sin( angle ) * _size;
        var cx :Number = _x + Math.cos( angleMid ) * ( _size / Math.cos( theta * .5 ) );
        var cy :Number = _y + Math.sin( angleMid ) * ( _size / Math.cos( theta * .5 ) );
        _gfx.curveTo( cx, cy, bx, by );
      }
      _gfx.lineTo( ox, oy );
    }
  }
}


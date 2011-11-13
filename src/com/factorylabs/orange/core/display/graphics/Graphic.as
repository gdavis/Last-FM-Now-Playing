
package com.factorylabs.orange.core.display.graphics
{
  import com.factorylabs.orange.core.display.fills.IFill;

  import flash.display.Graphics;
  import flash.errors.IllegalOperationError;

  /**
   * Graphic handles the basic necessities for creating a shape and starting and ending a fill or stroke through oranges drawing API.
   *
   * <p><strong><em>This is an abstract base class and is never instantiated.
   * It merely stores common properties and internal routines for all shape classes.</em></strong></p>
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
   * @version   1.1.0 :: Dec 3, 2009 :: Exposed this as a public class for ASDoc generation and to allow extension outside of this package.
   *                   :: Instantiatian now allows a shape to be stored without a gfx object to draw into, and can create a shape without a fill.
   */
  public class Graphic
    implements IGraphic
  {
    /**
     * @private
     */
    protected var _gfx      :Graphics;

    /**
     * @private
     */
    protected var _x      :Number;

    /**
     * @private
     */
    protected var _y      :Number;

    /**
     * @private
     */
    protected var _width    :Number;

    /**
     * @private
     */
    protected var _height   :Number;

    /**
     * @private
     */
    protected var _fill     :IFill;

    /**
     * @private
     */
    protected var _center   :Boolean;

    /**
     * @private
     */
    protected var _autoRedraw :Boolean;

    /**
     * @inheritDoc
     */
    public function get gfx() :Graphics
    {
      return _gfx;
    }
    public function set gfx( $gfx :Graphics ) :void
    {
      _gfx = $gfx;
      if( _autoRedraw )
        redraw();
    }

    /**
     * @inheritDoc
     */
    public function get x() :Number
    {
      return _x;
    }
    public function set x( $x :Number ) :void
    {
      _x = $x;
      if( _autoRedraw )
        redraw();
    }

    /**
     * @inheritDoc
     */
    public function get y() :Number
    {
      return _y;
    }
    public function set y( $y :Number ) :void
    {
      _y = $y;
      if( _autoRedraw )
        redraw();
    }

    /**
     * @inheritDoc
     */
    public function get width() :Number
    {
      return _width;
    }
    public function set width( $width :Number ) :void
    {
      _width = $width;
      if( _autoRedraw )
        redraw();
    }

    /**
     * @inheritDoc
     */
    public function get height() :Number
    {
      return _height;
    }
    public function set height( $height :Number ) :void
    {
      _height = $height;
      if( _autoRedraw )
        redraw();
    }

    /**
     * @inheritDoc
     */
    public function get fill() :IFill
    {
      return _fill;
    }
    public function set fill( $fill :IFill ) :void
    {
      _fill = $fill;
      if( _autoRedraw )
        redraw();
    }

    /**
     * @inheritDoc
     */
    public function get center() :Boolean
    {
      return _center;
    }
    public function set center( $center :Boolean ) :void
    {
      _center = $center;
      offset();
      if( _autoRedraw )
        redraw();
    }

    /**
     * @inheritDoc
     */
    public function get autoRedraw() :Boolean
    {
      return _autoRedraw;
    }
    public function set autoRedraw( $autoRedraw :Boolean ) :void
    {
      _autoRedraw = $autoRedraw;
    }

    /**
     * Base Constructor for setting and storing instance properties called from a subclass.
     * @param $gfx      Reference to the <code>shape.graphics</code> where the shape will be drawn into.
     * @param $x      A number indicating the horizontal position relative to the registration point of the parent display object.
     * @param $y      A number indicating the vertical position relative to the registration point of the parent display object.
     * @param $width    The <code>width</code> of the shape.
     * @param $height   The <code>height</code> of the shape.
     * @param $fill     Fill or line style to apply to the shape.
     * @param $center   Whether to draw the shape from a center registration.
     * @param $autoRedraw Determines if the graphic should auto redraw when a setter is called.
     */
    public function Graphic( $gfx :Graphics = null, $x :Number = 0, $y :Number = 0, $width :Number = 10, $height :Number = 10, $fill :IFill = null, $center :Boolean = false, $autoRedraw :Boolean = false )
    {
      _gfx = $gfx;
      _x = $x;
      _y = $y;
      _width = $width;
      _height = $height;
      _fill = $fill;
      _center = $center;
      _autoRedraw = $autoRedraw;
    }

    /**
     * @return  The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.graphics.Graphic';
    }

    /**
     * @inheritDoc
     */
    public function draw( $object :Object = null ) :void
    {
      if( $object )
        setProperties( $object );
      internalDraw();
    }

    /**
     * @inheritDoc
     */
    public function redraw() :void
    {
      _gfx.clear();
      internalDraw();
    }

    /**
     * @inheritDoc
     */
    public function setProperties( $object :Object ) :void
    {
      var auto :Boolean = _autoRedraw;
      _autoRedraw = false;

      for( var it :String in $object )
      {
        if( this.hasOwnProperty( it ) )
          this[ it ] = $object[ it ];
        else
          throw new ArgumentError( 'An invalid property assignment was attempted on ' + this.toString() + ' for the property ' + it );
      }
      _autoRedraw = auto;
    }

    /**
     * Calls subroutines for starting a fill/stroke, drawing the shape, and closing the fill/stroke.
     * <p>This will fail silently if the graphics object is null. If there is a null fill, it will draw the shape but not fill it.</p>
     */
    protected function internalDraw() :void
    {
      if( _center == true )
        offset();

      if( _gfx )
      {
        if( _fill != null )
          _fill.begin( _gfx, this );

        drawGraphic();

        if( _fill != null )
          _fill.end( _gfx );
      }
    }

    /**
     * Handles drawing the shape.
     * <p>This method should be overridden by the subclass to handle each shape's drawing routine.</p>
     * @throws  flash.errors.IllegalOperationError Method must be overridden by a subclass.
     */
    protected function drawGraphic() :void
    {
      throw new IllegalOperationError( this.toString() + ' : the drawGraphic() method must be invoked by a subclass.' );
    }

    /**
     * Handles drawing the offset from the center registration.
     */
    protected function offset() :void
    {
      _x = _width * .5;
      _y = _height * .5;
    }
  }
}


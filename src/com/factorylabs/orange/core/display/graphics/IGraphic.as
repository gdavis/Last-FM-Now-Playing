
package com.factorylabs.orange.core.display.graphics
{
  import com.factorylabs.orange.core.display.fills.IFill;

  import flash.display.Graphics;

  /**
   * IGraphic is the interface used for drawing graphic shapes.
   *
   * <p>We've run performance tests against the native <code>GraphicsSolidFill</code> through the <code>drawGraphicsData</code> and this runs about 96% faster.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @example The following code creates a class which shows examples of all shapes and fills for use with the drawing API.
   * <listing version="3.0" >
   *  package com.factorylabs.barebones.views
   *  {
   *    import flash.display.BitmapData;
   *    import flash.display.Loader;
   *    import flash.events.Event;
   *    import flash.net.URLRequest;
   *    import com.factorylabs.orange.core.display.FSprite;
   *    import com.factorylabs.orange.core.display.graphics.FArcLine;
   *    import com.factorylabs.orange.core.display.graphics.FArrow;
   *    import com.factorylabs.orange.core.display.graphics.FCircle;
   *    import com.factorylabs.orange.core.display.graphics.FDashedLine;
   *    import com.factorylabs.orange.core.display.graphics.FEllipse;
   *    import com.factorylabs.orange.core.display.graphics.FPolyFromPoints;
   *    import com.factorylabs.orange.core.display.graphics.FPolygon;
   *    import com.factorylabs.orange.core.display.graphics.FRectCornered;
   *    import com.factorylabs.orange.core.display.graphics.FRectCorneredComplex;
   *    import com.factorylabs.orange.core.display.graphics.FRectRound;
   *    import com.factorylabs.orange.core.display.graphics.FRectRoundComplex;
   *    import com.factorylabs.orange.core.display.graphics.FRectangle;
   *    import com.factorylabs.orange.core.display.graphics.FSquare;
   *    import com.factorylabs.orange.core.display.graphics.FWedge;
   *    import com.factorylabs.orange.core.display.fills.BitMapFill;
   *    import com.factorylabs.orange.core.display.fills.GradientFill;
   *    import com.factorylabs.orange.core.display.fills.GradientStroke;
   *    import com.factorylabs.orange.core.display.fills.SolidFill;
   *    import com.factorylabs.orange.core.display.fills.SolidStroke;
   *
   *    public class GraphicsTest
   *    {
   *      private var _gfx  :FSprite;
   *      private var _loader :Loader;
   *      private var _sf   :SolidFill;
   *      private var _gf   :GradientFill;
   *      private var _bf   :BitMapFill;
   *      private var _ss   :SolidStroke;
   *      private var _gs   :GradientStroke;
   *
   *      public function GraphicsTest( $container :FSprite )
   *      {
   *        _gfx = new FSprite( $container, { x: 20, y: 100 } );
   *        load();
   *      }
   *
   *      private function load() :void
   *      {
   *        var url :String = 'media/images/missing.png';
   *        _loader = new Loader();
   *        var request :URLRequest = new URLRequest( url );
   *        _loader.load( request );
   *        _loader.contentLoaderInfo.addEventListener( Event.COMPLETE, draw );
   *      }
   *
   *      private function draw( $e :Event ) :void
   *      {
   *        _sf = new SolidFill( 0x666666 );
   *        _gf = new GradientFill( 0, [ 0xffffff, 0x333333 ] );
   *        _bf = new BitMapFill( new BitmapData( _loader.width, _loader.height, true ), _loader );
   *        _ss = new SolidStroke( 0xcccccc, 1, 3, true );
   *        _gs = new GradientStroke( _gf, _ss );
   *
   *        drawRectangles();
   *        drawCircles();
   *        drawRectRound();
   *        drawRectComplex();
   *        drawPolys();
   *        drawPolyFromPoints();
   *        drawWedges();
   *        drawLines();
   *      }
   *
   *      private function drawRectangles() :void
   *      {
   *        var r1 :FRectangle = new FRectangle( _gfx.graphics, 0, 0, 200, 100, _sf );
   *        var r2 :FRectangle = new FRectangle( _gfx.graphics, 210, 0, 200, 100, _gf );
   *        var r3 :FRectangle = new FRectangle( _gfx.graphics, 420, 0, 200, 100, _bf );
   *
   *        var s1 :FSquare = new FSquare( _gfx.graphics, 0, 110, 200, _sf );
   *        var s2 :FSquare = new FSquare( _gfx.graphics, 210, 110, 200, _gf );
   *        var s3 :FSquare = new FSquare( _gfx.graphics, 420, 110, 200, _bf );
   *
   *        var rs1 :FRectangle = new FRectangle( _gfx.graphics, 630, 0, 200, 100, _ss );
   *        var ss1 :FSquare = new FSquare( _gfx.graphics, 630, 110, 200, _gs );
   *      }
   *
   *      private function drawCircles() :void
   *      {
   *        var e1 :FEllipse = new FEllipse( _gfx.graphics, 0, 0, 200, 100, _sf );
   *        var e2 :FEllipse = new FEllipse( _gfx.graphics, 210, 0, 200, 100, _gf );
   *        var e3 :FEllipse = new FEllipse( _gfx.graphics, 420, 0, 200, 100, _bf );
   *
   *        var c1 :FCircle = new FCircle( _gfx.graphics, 0, 110, 200, _sf );
   *        var c2 :FCircle = new FCircle( _gfx.graphics, 210, 110, 200, _gf );
   *        var c3 :FCircle = new FCircle( _gfx.graphics, 420, 110, 200, _bf );
   *
   *        var es1 : FEllipse = new FEllipse( _gfx.graphics, 630, 0, 200, 100, _ss );
   *        var cs1 : FCircle = new FCircle( _gfx.graphics, 630, 110, 200, _gs );
   *      }
   *
   *      private function drawRectRound() :void
   *      {
   *        var r1 :FRectRoundComplex = new FRectRoundComplex( _gfx.graphics, 0, 0, 200, 100, _sf, 10, 10, 0, 0 );
   *        var r2 :FRectRoundComplex = new FRectRoundComplex( _gfx.graphics, 210, 0, 200, 100, _gf, 10, 10, 0, 0 );
   *        var r3 :FRectRoundComplex = new FRectRoundComplex( _gfx.graphics, 420, 0, 200, 100, _bf, 10, 10, 0, 0 );
   *
   *        var c1 :FRectRound = new FRectRound( _gfx.graphics, 0, 110, 200, 100, _sf, 10 );
   *        var c2 :FRectRound = new FRectRound( _gfx.graphics, 210, 110, 200, 100, _gf, 10 );
   *        var c3 :FRectRound = new FRectRound( _gfx.graphics, 420, 110, 200, 100, _bf, 10 );
   *
   *        var rs1 :FRectRoundComplex = new FRectRoundComplex( _gfx.graphics, 630, 0, 200, 100, _ss, 10, 10, 0, 0 );
   *        var cs1 :FRectRound = new FRectRound( _gfx.graphics, 630, 110, 200, 100, _gs, 10 );
   *      }
   *
   *      private function drawRectComplex() :void
   *      {
   *        var r1 :FRectCorneredComplex = new FRectCorneredComplex( _gfx.graphics, 0, 0, 200, 100, _sf, 10, 10, 0, 0 );
   *        var r2 :FRectCorneredComplex = new FRectCorneredComplex( _gfx.graphics, 210, 0, 200, 100, _gf, 10, 10, 0, 0 );
   *        var r3 :FRectCorneredComplex = new FRectCorneredComplex( _gfx.graphics, 420, 0, 200, 100, _bf, 10, 10, 0, 0 );
   *
   *        var c1 :FRectCornered = new FRectCornered( _gfx.graphics, 0, 110, 200, 100, _sf, 10 );
   *        var c2 :FRectCornered = new FRectCornered( _gfx.graphics, 210, 110, 200, 100, _gf, 10 );
   *        var c3 :FRectCornered = new FRectCornered( _gfx.graphics, 420, 110, 200, 100, _bf, 10 );
   *
   *        var rs1 :FRectCorneredComplex = new FRectCorneredComplex( _gfx.graphics, 630, 0, 200, 100, _ss, 10, 10, 0, 0 );
   *        var cs1 :FRectCornered = new FRectCornered( _gfx.graphics, 630, 110, 200, 100, _gs, 10 );
   *      }
   *
   *      private function drawPolys() :void
   *      {
   *        var p1 :FPolygon = new FPolygon( _gfx.graphics, 50, 0, 5, 50, 0, _sf );
   *        var p2 :FPolygon = new FPolygon( _gfx.graphics, 150, 0, 5, 50, 0, _gf );
   *        var p3 :FPolygon = new FPolygon( _gfx.graphics, 250, 0, 5, 50, 0, _bf );
   *
   *        var a1 :FArrow = new FArrow( _gfx.graphics, 50, 110, 50, _sf, FArrow.UP );
   *        var a2 :FArrow = new FArrow( _gfx.graphics, 150, 110, 50, _gf, FArrow.DOWN );
   *        var a3 :FArrow = new FArrow( _gfx.graphics, 250, 110, 50, _bf, FArrow.LEFT );
   *
   *        var ps1 :FPolygon = new FPolygon( _gfx.graphics, 350, 0, 5, 50, 0, _ss );
   *        var as1 :FArrow = new FArrow( _gfx.graphics, 350, 110, 50, _gs, FArrow.RIGHT );
   *      }
   *
   *      private function drawPolyFromPoints() :void
   *      {
   *        var f1 :FPolyFromPoints = new FPolyFromPoints( _gfx.graphics, [ [0, 0], [0, 100], [100, 200], [ 350, 300] ], _sf );
   *        var f2 :FPolyFromPoints = new FPolyFromPoints( _gfx.graphics, [ [200, 0], [200, 100], [300, 200], [ 550, 300] ], _gf );
   *        var f3 :FPolyFromPoints = new FPolyFromPoints( _gfx.graphics, [ [400, 0], [400, 100], [500, 200], [ 750, 300] ], _bf );
   *
   *        var fs1 :FPolyFromPoints = new FPolyFromPoints( _gfx.graphics, [ [600, 0], [600, 100], [700, 200], [ 850, 300] ], _ss );
   *        var fs2 :FPolyFromPoints = new FPolyFromPoints( _gfx.graphics, [ [800, 0], [800, 100], [900, 200], [ 950, 300] ], _gs );
   *      }
   *
   *      private function drawWedges() :void
   *      {
   *        var w1 :FWedge = new FWedge( _gfx.graphics, 200, 150, 50, 180, _sf, FWedge.CLOCKWISE, 0 );
   *        var w2 :FWedge = new FWedge( _gfx.graphics, 320, 150, 50, 270, _gf, FWedge.COUNTER_CLOCKWISE, 0 );
   *        var w3 :FWedge = new FWedge( _gfx.graphics, 440, 150, 50, 270, _bf, FWedge.CLOCKWISE, 0 );
   *
   *        var w4 :FWedge = new FWedge( _gfx.graphics, 560, 150, 50, 210, _ss, FWedge.COUNTER_CLOCKWISE, 0 );
   *      }
   *
   *      private function drawLines() :void
   *      {
   *        var dl :FDashedLine = new FDashedLine( _gfx.graphics, 0, 0, 500, 0, 5, 5, _ss );
   *        var al :FArcLine = new FArcLine( _gfx.graphics, 500, 200, 50, 100, -210, _gs );
   *      }
   *    }
   *  }
   * </listing>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Jun 1, 2008
   */
  public interface IGraphic
  {
    /**
     * The <code>shape.graphics</code> object used for drawing the shape.
     * <p>If <code>autoRedraw</code> is set to true, the <code>IGraphic</code> will redraw itself.
     */
    function get gfx() :Graphics;
    function set gfx( $gfx :Graphics ) :void;

    /**
     * The <code>x</code> coordinate of the <code>IGraphic</code>.
     * <p>If <code>autoRedraw</code> is set to true, the <code>IGraphic</code> will redraw itself.
     */
    function get x() :Number;
    function set x( $x :Number ) :void;

    /**
     * The <code>y</code> coordinate of the <code>IGraphic</code>.
     * <p>If <code>autoRedraw</code> is set to true, the <code>IGraphic</code> will redraw itself.
     */
    function get y() :Number;
    function set y( $y :Number ) :void;

    /**
     * The <code>width</code> value of the <code>IGraphic</code>.
     * <p>If <code>autoRedraw</code> is set to true, the <code>IGraphic</code> will redraw itself.
     */
    function get width() :Number;
    function set width( $width :Number ) :void;

    /**
     * The <code>height</code> value of the <code>IGraphic</code>.
     * <p>If <code>autoRedraw</code> is set to true, the <code>IGraphic</code> will redraw itself.
     */
    function get height() :Number;
    function set height( $height :Number ) :void;

    /**
     * The <code>IFill</code> object used to fill or stroke the <code>IGraphic</code>.
     * <p>If <code>autoRedraw</code> is set to true, the <code>IGraphic</code> will redraw itself.
     */
    function get fill() :IFill;
    function set fill( $fill :IFill ) :void

    /**
     * Whether the <code>IGraphic</code> draws from it's center registration mark.
     * <p>If <code>autoRedraw</code> is set to true, the <code>IGraphic</code> will redraw itself.
     */
    function get center() :Boolean;
    function set center( $center :Boolean ) :void;

    /**
     * Whether the <code>IGraphic</code> automatically redraws on a property setter.
     */
    function get autoRedraw() :Boolean;
    function set autoRedraw( $autoRedraw :Boolean ) :void;

    /**
     * Allows the <code>IGraphic</code> object to draw a shape based on the properties set.
     *<p>This promotes reuse of a single <code>IGraphic</code> object, by applying setter properties and allowing the graphic to reuse it's drawing routines.
     * @param $object Optional object map of properties to be set prior to calling the internal drawing routine, this is a convenience though, setting the properties directly is much faster.
     *
     * @example The following code sets up a drawing object then reuses it to draw a few more shapes.
     * <listing version="3.0" >
     * var sf :SolidFill = new SolidFill( 0x666666, .8 );
     * var hr :FRectangle = new FRectangle( _gfx.graphics, 0, 0, stage.stageWidth, 1, sf );
     * hr.draw( { y: 100 } );
     * hr.draw( { y: 200 } );
     * </listing>
     */
    function draw( $object :Object = null ) :void;

    /**
     * Redraws the shape.
     * <p>If the <code>autoRedraw</code> property is set to true, a setter will automatically call this method.</p>
     * <p><em>Note:</em> This will call <code>clear()</code> on the <code>shape.graphics</code> object and clear all existing grapics witihin that object.</p>
     *
     * @example The following code draws then redraws a rectangle.
     * <listing version="3.0" >
     * var sf :SolidFill = new SolidFill( 0x666666, .8 );
     * var r1 :FRectangle = new FRectangle( _gfx.graphics, 0, 0, 200, 100, sf );
     * r1.width = 500;
     * r1.redraw();
     * </listing>
     */
    function redraw() :void;

    /**
     * Maps all the object's properties to the <code>IGraphic</code>.
     * <p>If there are properties that do not exist, an error is thrown.</p>
     * <p>Disables the <code>autoRedraw</code> property while properties are being set.</p>
     * @param $object Object to map properties from.
     * @throws  ArgumentError <code>ArgumentError</code> When an invalid property assignment was attempted.
     */
    function setProperties( $object :Object ) :void;
  }
}


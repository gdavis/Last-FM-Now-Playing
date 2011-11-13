
package com.factorylabs.orange.core.display.stage
{
  import com.factorylabs.orange.core.signals.StageSignal;
  import com.factorylabs.orange.core.display.graphics.FRectangle;
  import com.factorylabs.orange.core.IDisposable;
  import com.factorylabs.orange.core.display.FSprite;
  import com.factorylabs.orange.core.display.fills.IFill;
  import com.factorylabs.orange.core.display.fills.SolidFill;

  import flash.display.DisplayObjectContainer;

  /**
   * Draws the application background.
   *
   * <p>This class listens for stage resize signals and redraws the background to fill the entire area.</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Grant Davis, Matthew Kitt
   * @version   1.0.0 :: 10.31.2007
   * @version   1.5.0 :: 03.06.2009 :: Simplified and lightened to remove StageInfo object.
   * @version   2.0.0 :: 02.05.2010 :: Pulled the event system out in favor of Robert Penner's Signals.
   * @since   1.0.0
   */
  public class StageBackground
    extends FSprite
      implements IDisposable
  {
    /**
     * @private
     */
    protected var _fill       :IFill;

    /**
     * @private
     */
    protected var _appWidth     :int;

    /**
     * @private
     */
    protected var _appHeight    :int;

    /**
     * @private
     */
    protected var _shape      :FRectangle;

    /**
     * @private
     */
    protected var _signal     :StageSignal;

    /**
     * The fill object to use in drawing the background.
     */
    public function get fill() :IFill { return _fill; }
    public function set fill( $fill :IFill ) :void
    {
      _fill = $fill;
      draw();
    }

    /**
     * Creates the StageBackground instance.
     * @param $holder   The container object to create the background in.
     * @param $signal   The single instance of the <code>StageSignal</code> listening for resize events.
     * @param $appWidth   The default <code>width</code> of the application.
     * @param $appHeight  The default <code>height</code> of the application.
     * @param $fill     Implementation of an <code>IFill</code> object to apply to the stage.
     * @param $init     Overridable properties.
     *
     * @example The following code creates a background for the stage.
     * <listing version="3.0" >
     * _stageBackground = new StageBackground( _document, _stageSignal, appWidth, appHeight, new SolidFill( 0xFF8500 ) );
     * </listing>
     */
    public function StageBackground( $holder :DisplayObjectContainer, $signal :StageSignal, $appWidth :int, $appHeight :int, $fill :IFill = null, $init :Object = null )
    {
      super( $holder, $init );
      _signal = $signal;
      _appWidth = $appWidth;
      _appHeight = $appHeight;
      _fill =  $fill || new SolidFill( 0xFF8500 );
      initialize();
    }

    /**
     * @inheritDoc
     */
    override public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.stage.StageBackground';
    }

    /**
     * Forces the background to reset its properties and redraw itself.
     */
    public function redraw() :void
    {
      draw();
    }

    /**
     * @inheritDoc
     */
    public function dispose() :void
    {
      _signal.remove( onResize );
      graphics.clear();
    }

    /**
     * Initializes the StageBackground properties.
     * <p>Subclass this method to customize how the initialization process occcurs.</p>
     */
    protected function initialize() :void
    {
      _shape = new FRectangle( graphics, 0, 0, 0, 0, _fill );
      draw();
      _signal.add( onResize );
    }

    /**
     * Draws the background.
     * <p>Subclass this method to customize how the background is drawn.</p>
     */
    protected function draw() :void
    {
      var wv :int = stage.stageWidth;
      var hv :int = stage.stageHeight;

      _shape.width = wv;
      _shape.height = hv;
      _shape.x = Math.round( ( _appWidth - wv ) * .5 );
      _shape.y = Math.round( ( _appHeight - hv ) * .5 );
      graphics.clear();
      _shape.draw();
    }

    /**
     * Captures resize signals from the <code>StageSignal</code> and instructs the background to redraw.
     * <p>Subclass this method to customize how the stage events are captured.</p>
     */
    protected function onResize() :void
    {
      draw();
    }
  }
}



package com.factorylabs.orange.core.display
{
  import org.osflash.signals.Signal;
  import com.factorylabs.orange.core.IDisposable;

  import flash.display.DisplayObjectContainer;
  import flash.events.MouseEvent;

  /**
   * This is a basic button acting as an abstract class.
   *
   * <p>Meant to be subclassed and override methods specifically for the actions required by an instance.
   * Performs some basic operations for setting up a display button including a few basic states.
   * A button should not manage it's own states, rather be told by a Mediator what actions to perform. The button
   * listens for it's own <code>MouseEvent.CLICK</code> and utilizes a <code>click</code> signal to redispatch
   * it's <code>CLICK</code> mouse event. Objects wishing to listen to the buttons <code>click</code> event (signal)
   * should use the following: <code>_button.click.add( onClick );</code> and handle this event with the
   * <code>MouseEvent</code> parameter. So much prettier.</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Feb 8, 2010
   */
  public class FButton
    extends FMovieClip
      implements IDisposable
  {
    /**
     * @private
     */
    protected var _enabled    :Boolean = true;

    /**
     * @private
     */
    protected var _selected   :Boolean = false;

    /**
     * @private
     */
    protected var _highlighted  :Boolean = false;

    /**
     * @private
     */
    protected var _click    :Signal;

    /**
     * Flag for the enabled state, makes assumptions for <code>mouseEnabled</code>, <code>buttonMode</code>, <code>useHandCursor</code>
     */
    override public function get enabled() :Boolean { return _enabled; }
    override public function set enabled( $enabled :Boolean ) :void
    {
      _enabled = $enabled;
      mouseEnabled = $enabled;
      buttonMode = $enabled;
      useHandCursor = $enabled;
      super.enabled = $enabled;
    }

    /**
     * Flag denoting the selected state of the button.
     */
    public function get selected() :Boolean { return _selected; }
    public function set selected( $selected :Boolean ) :void
    {
      _selected = $selected;
    }

    /**
     * Flag denoting the highlighted state of the button.
     */
    public function get highlighted() :Boolean { return _highlighted; }
    public function set highlighted( $highlighted :Boolean ) :void
    {
      _highlighted = $highlighted;
    }

    /**
     * The accessor for the <code>MouseEvent.CLICK Signal</code>.
     */
    public function get click() :Signal { return _click; }

    /**
     * @inheritDoc
     * Constructs an FButton and the click signal.
     */
    public function FButton( $container :DisplayObjectContainer = null, $init :Object = null )
    {
      mouseChildren = false;
      enabled = true;
      super( $container, $init );
      addListeners();
      _click = new Signal( MouseEvent );
    }

    /**
     * @inheritDoc
     */
    override public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.FButton';
    }

    /**
     * Allows the signals and listeners to be cleaned up.
     * <p>All subclasses should handle it's own clean up as well as calling <code>super.dispose()</code>.</p>
     */
    public function dispose() :void
    {
      removeListeners();
      _click.removeAll();
      _click = null;
    }

    /**
     * Adds any MouseEvent listeners to the instance for handling drawing in response to events.
     * <p>If a subclass needs to listen to more events other than <code>MouseEvent.CLICK</code> it should override
     * this method as well as calling <code>super.addListeners()</code>. Commented out listeners are provided for
     * reference only.</p>
     */
    protected function addListeners() :void
    {
      addEventListener( MouseEvent.CLICK, onClick );
//      addEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
//      addEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
//      addEventListener( MouseEvent.ROLL_OVER, onRollOver );
//      addEventListener( MouseEvent.ROLL_OUT, onRollOut );
//      addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
//      addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
//      addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
//      addEventListener( MouseEvent.DOUBLE_CLICK, onDoubleClick );
//      addEventListener( MouseEvent.MOUSE_WHEEL, onMouseWheel );
    }

    /**
     * Removes any MouseEvent listeners from the instance for created for handling drawing in response to events.
     * <p>If a subclass is listening to more events other than <code>MouseEvent.CLICK</code> it should override
     * this method as well as calling <code>super.removeListeners()</code>. Commented out listeners are provided for
     * reference only.</p>
     */
    protected function removeListeners() :void
    {
      removeEventListener( MouseEvent.CLICK, onClick );
//      removeEventListener( MouseEvent.MOUSE_OVER, onMouseOver );
//      removeEventListener( MouseEvent.MOUSE_OUT, onMouseOut );
//      removeEventListener( MouseEvent.ROLL_OVER, onRollOver );
//      removeEventListener( MouseEvent.ROLL_OUT, onRollOut );
//      removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
//      removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
//      removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
//      removeEventListener( MouseEvent.DOUBLE_CLICK, onDoubleClick );
//      removeEventListener( MouseEvent.MOUSE_WHEEL, onMouseWheel );
    }

    /**
     * Dispatches the <code>MouseEvent</code> as a <code>Signal</code>.
     */
    protected function onClick( $e :MouseEvent ) :void
    {
      click.dispatch( $e );
    }
  }
}



package com.factorylabs.orange.core.signals
{
  import com.factorylabs.orange.core.IDisposable;
  import flash.events.Event;
  import org.osflash.signals.Signal;

  import flash.display.Stage;

  /**
   * Rebroadcasts stage resize events as Signals.
   *
   * <p>There should only be one instance of <code>StageSignal</code> in an application.</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Feb 5, 2010
   */
  public class StageSignal
    extends Signal
      implements IDisposable
  {
    /**
     * @private
     */
    private var _stage :Stage;

    /**
     * Returns the <code>Stage</code> object listening to <code>Event.RESIZE</code>
     */
    public function get stage() :Stage { return _stage; }

    /**
     * Initialze a stage signal.
     * @param $stage  The stage object used for resizing.
     */
    public function StageSignal( $stage :Stage )
    {
      super();
      _stage = $stage;
      addStageListeners();
    }

    /**
     * @return  The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.signals.StageSignal';
    }

    /**
     * Clean this puppy up, this shit is being killed.
     */
    public function dispose() :void
    {
      _stage.removeEventListener( Event.RESIZE, onResize, false );
    }

    public function forceResize() :void
    {
      _stage.dispatchEvent( new Event( Event.RESIZE ) );
    }

    /**
     * Listen for the <code>Stage</code>'s <code>Event.RESIZE</code> dispatch.
     * <p>Listen to stage with high priority so the values are internally updated before
     * another object listening to stage resize is called.</p>
     */
    protected function addStageListeners() :void
    {
      _stage.addEventListener( Event.RESIZE, onResize, false, uint.MAX_VALUE );
    }

    /**
     * Forward the resize as a signal.
     */
    protected function onResize( $e :Event ) :void
    {
      dispatch();
    }
  }
}


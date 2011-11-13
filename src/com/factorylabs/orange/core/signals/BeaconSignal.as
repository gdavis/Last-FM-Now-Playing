
package com.factorylabs.orange.core.signals
{
  import flash.display.MovieClip;
  import org.osflash.signals.Signal;

  /**
   * Broadcasts a signal on each tick of the frame similar to an EnterFrame Event.
   *
   * <p>Subclass of Robert Penner's <code>Signal</code> which utilizes an empty 2 frame looping <code>MovieClip</code>
   * for dispatching events. This should be used in place of the native <code>ENTER_FRAME</code> events for performance
   * optimization. It's recommend there is only a single instance of this class created and injected at startup for
   * any classes needing it's functionality.</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Feb 4, 2010
   */
  public class BeaconSignal
    extends Signal
  {
    /**
     * @private
     */
    protected var _twoframe :MovieClip;

    /**
     * Instantiates a beacon instance.
     *
     * @param $mc A 2 frame <code>MovieClip</code> used for creating the loop events.
     *
     * @example The following code instantiates and starts listening to a beacon.
     * <listing version="3.0" >
     * protected var beacon :BeaconSignal = new BeaconSignal();
     * _beacon.add( beaconTick );
     * </listing>
     */
    public function BeaconSignal( $mc :MovieClip )
    {
      super();
      _twoframe = $mc;
      _twoframe.stop();
      addFrameScripts( );
      _twoframe.nextFrame();
    }

    /**
     * @return The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.signals.BeaconSignal';
    }

    /**
     * Tells the two frame movie clip to start looping.
     * @inheritDoc
     */
    override public function add( listener :Function ) :void
    {
      super.add( listener );
      play();
    }

    /**
     * Tells the two frame movie clip to start looping.
     * @inheritDoc
     */
    override public function addOnce( listener :Function ) :void
    {
      super.addOnce( listener );
      play();
    }

    /**
     * Tells the two frame movie clip to stop looping if there are no more listeners.
     * @inheritDoc
     */
    override public function remove( listener :Function ) :void
    {
      super.remove( listener );
      if( numListeners < 1 )
        stop();
    }

    /**
     * Tells the two frame movie clip to stop looping if there are no more listeners.
     * @inheritDoc
     */
    override public function removeAll() :void
    {
      super.removeAll();
      stop();
    }

    /**
     * Sends the <code>dispatch</code> method to listeners via <code>Signals</code> every frame tick.
     */
    public function tick() :void
    {
      super.dispatch();
    }

    /**
     * Tells the two frame movie clip to start looping.
     * <p>If there are listeners they will start responding to signals.</p>
     */
    public function play() :void
    {
      _twoframe.play();
    }

    /**
     * Tells the two frame movie clip to stop looping.
     * <p>If there are listeners they will stop responding to signals.</p>
     */
    public function stop() :void
    {
      _twoframe.stop();
    }

    /**
     * @private
     */
    protected function addFrameScripts() :void
    {
      _twoframe.addFrameScript( 0, tick, 1, tick );
    }
  }
}


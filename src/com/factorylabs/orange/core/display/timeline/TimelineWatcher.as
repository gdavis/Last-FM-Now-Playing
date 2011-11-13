
package com.factorylabs.orange.core.display.timeline
{
  import org.osflash.signals.Signal;
  import com.factorylabs.orange.core.IDisposable;
  import com.factorylabs.orange.core.signals.BeaconSignal;

  import flash.display.MovieClip;

  /**
   * Watches the timeline of a MovieClip and dispatches signals when a frame label or end of the timeline is reached.
   *
   * <p>Originally concept by <a target="_top" href="http://www.refunk.com/">Refunk</a>.</p>
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
  public class TimelineWatcher
    implements IDisposable
  {
    /**
     * @private
     */
    protected var _timeline     :MovieClip;

    /**
     * @private
     */
    protected var _beacon     :BeaconSignal;

    /**
     * @private
     */
    protected var _labelSignal    :Signal;

    /**
     * @private
     */
    protected var _endSignal    :Signal;

    /**
     * @private
     */
    protected var _previousLabel  :String;

    /**
     * The timeline of the <code>MovieClip</code> being watched.
     */
    public function get timeline() :MovieClip { return _timeline; }

    /**
     * The <code>Signal</code> dispatching frame label singals.
     */
    public function get labelSignal() :Signal { return _labelSignal; }

    /**
     * The <code>Signal</code> dispatching when the timeline reaches the end.
     */
    public function get endSignal() :Signal { return _endSignal; }

    /**
     * The TimelineWatcher class provides functionality to watch a <code>MovieClip</code>'s timeline.
     *
     * @param $timeline The <code>MovieClip</code> timeline to be watched.
     * @param $beacon The <code>BeaconSignal</code> used in replace of an <code>ENTER_FRAME</code> event.
     *
     * @example The following code instantiates a timeline watcher.
     * <listing version="3.0" >
     * _watcher = new TimelineWatcher( _mc, _beacon );
     * _end = _watcher.endSignal;
     * _label = _watcher.labelSignal;
     * _end.add( onTimelineComplete );
     * _label.add( onLabelReached );
     *
     * protected function onTimelineComplete( $frame :int, $label :String ) :void
     * {
     *    // do something when the timeline ends..
     * }
     *
     * protected function onLabelReached( $frame :int, $label :String ) :void
     * {
     *    if( $label == 'awesome' )
     *      // do something awesome;
     *
     *    if( $label == 'not_awesome' )
     *      // do something not awesome;
     * }
     * </listing>
     */
    public function TimelineWatcher( $timeline :MovieClip, $beacon :BeaconSignal )
    {
      _timeline = $timeline;
      _beacon = $beacon;
      _labelSignal = new Signal( int, String );
      _endSignal = new Signal( int, String );
      _beacon.add( watch );
    }

    /**
     * @return The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.timeline.TimelineWatcher';
    }

    /**
     * Dispose a TimelineWatcher instance.
     */
    public function dispose() :void
    {
      _labelSignal.removeAll();
      _endSignal.removeAll();
      _beacon.remove( watch );
      _beacon = null;
      _timeline = null;
    }

    protected function watch() :void
    {
      var cf :int = _timeline.currentFrame;
      var cl :String = _timeline.currentLabel;

      if( cl != _previousLabel )
        _labelSignal.dispatch( cf, cl );

      if( cf == _timeline.totalFrames )
        _endSignal.dispatch( cf, cl );

      _previousLabel = cl;
    }
  }
}


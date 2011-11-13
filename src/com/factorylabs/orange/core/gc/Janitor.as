
package com.factorylabs.orange.core.gc
{
  import com.factorylabs.orange.core.IDisposable;

  import flash.display.Bitmap;
  import flash.display.DisplayObject;
  import flash.display.DisplayObjectContainer;
  import flash.display.Loader;
  import flash.display.MovieClip;
  import flash.events.IEventDispatcher;
  import flash.utils.Dictionary;
  import flash.utils.Timer;

  /**
   * The Janitor is used for garbage collection.
   *
   * <p>Janitor has methods within it to add and remove various objects that need to be removed from memory. There is also a one off clean method to collect everything.</p>
   *
   * <p>The following people are credited with originating all or parts of this code:<br />
   * Grant Skinner :: www.gskinner.com</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * TODO It might be more convenient to change the Dictionary's to Maps, this way we we can access disposables and listeners via Keys.. ? – MK.
   * TODO It would be awesome if we could clean up the FDT warnings triggered by cleanUpConnections method. – MK.
   * TODO We should add some wrapper classes in for clearing out Signals as well. – MK.
   *
   * @author    Grant Skinner
   * @author    Ryan Boyajian
   * @author    Matthew Kitt
   * @version   1.0.0 :: Aug 19, 2008
   * @version   1.5.0 :: March 6, 2009 :: Removed SoundChannel, Intervals, Timeouts, Timers, and Connections to lighten the load, implemented an interface for cleanUp.
   */
  public class Janitor
    implements IJanitor
  {
    private var _target     :Object;
    private var _listeners    :Dictionary;
    private var _disposables  :Dictionary;
    private var _connections  :Dictionary;
    private var _timers     :Dictionary;

    /**
     * The <code>Dictionary</code> of event listeners.
     */
    public function get listeners() :Dictionary { return _listeners; }

    /**
     * The <code>Dictionary</code> of disposable objects.
     */
    public function get disposables() :Dictionary { return _disposables; }

    /**
     * The <code>Dictionary</code> for storing connections.
     */
    public function get connections() :Dictionary { return _connections; }

    /**
     * The <code>Dictionary</code> for storing timers.
     */
    public function get timers() :Dictionary { return _timers; }

    /**
     * Create an instance of a <code>Janitor</code>.
     * @param $target Cleanup that dirty little object.
     */
    public function Janitor( $target :Object )
    {
      _target = $target;
    }

    /**
     * @return  string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.gc.Janitor';
    }

    /**
     * @inheritDoc
     */
    public function cleanUp() :void
    {
      cleanUpEventListeners();
      cleanUpConnections();
      cleanUpTimers();
      cleanUpChildren();
      cleanUpDisposables();
      cleanUpTarget();
    }

    /**
     * Adds an event listener for forwarding from the <code>Janitor</code> object.
     * <p>Skinner note: useWeakReference is always true, this is a bit convoluted, but we don't want to maintain strong references back to event dispatchers.</p>
     * @param $dispatcher The object sending out the event.
     * @param $type     The Event.type
     * @param $listener   The callback function
     * @param $useCapture Determines whether the listener works in the capture phase or the target and bubbling phases.
     * @param $add      Whether to actually listen or not.
     * @param $priority   The level of priority, the higher the number the greater the priority.
     */
    public function addEventListener( $dispatcher :IEventDispatcher, $type :String, $listener :Function, $useCapture :Boolean = false, $add :Boolean = true, $priority :int = 0 ) :void
    {
      if( $add ) $dispatcher.addEventListener( $type, $listener, $useCapture, $priority, true );
      if ( !_listeners ) _listeners = new Dictionary( true );

      var hash :Object = _listeners[ $dispatcher ];
      if( !hash ) hash = _listeners[ $dispatcher ] = {};

      var arr :Array = hash[ $type ];
      if( !arr ) hash[ $type ] = arr = [];

      var dl :uint = arr.length;
      for( var i :uint = 0; i < dl; i++ )
      {
        var obj :Object = arr[ i ];
        if( obj[ 'listener' ] == $listener && obj[ 'useCapture' ] == $useCapture ) return;
      }
      arr.push( { listener: $listener, useCapture: $useCapture } );
    }

    /**
     * Removes an event listener via the <code>Janitor</code> object.
     * @param $dispatcher The object sending out the event.
     * @param $type     The Event.type
     * @param $listener   The callback function
     * @param $useCapture Determines whether the listener works in the capture phase or the target and bubbling phases.
     * @param $remove   Whether to remove it from the dispatcher or just the janitor.
     */
    public function removeEventListener( $dispatcher :IEventDispatcher, $type :String, $listener :Function, $useCapture :Boolean = false, $remove :Boolean = true ) :void
    {
      if( $remove ) $dispatcher.removeEventListener( $type, $listener, $useCapture );
      if( !_listeners || !_listeners[ $dispatcher ] || !_listeners[ $dispatcher ][ $type ] ) return;

      var arr :Array = _listeners[ $dispatcher ][ $type ];
      var dl  :uint = arr.length;

      for( var i :uint = 0; i < dl; i++ )
      {
        var obj :Object = arr[ i ];
        if( obj[ 'listener' ] == $listener && obj[ 'useCapture' ] == $useCapture )
        {
          arr.splice( i, 1 );
          delete _listeners[ $dispatcher ][ $type ];
          return;
        }
      }
    }

    /**
     * Cleans up event listeners that have been added through this <code>Janitor</code> object.
     */
    public function cleanUpEventListeners() :void
    {
      for( var dispatcher :Object in _listeners )
      {
        var hash :Object = _listeners[ dispatcher ];
        for( var type :String in hash )
        {
          var arr :Array = hash[ type ];
          while( arr.length > 0 )
          {
            var obj :Object = arr.pop();
            try
            {
              removeEventListener( ( IEventDispatcher( dispatcher ) ), type, Function( ( obj[ 'listener' ] ) ), Boolean( obj[ 'useCapture' ] ) );
            } catch (e:*) {}
          }
        }
      }
      _listeners = null;
    }

    /**
     * Modified gSkinner's function to recursively remove children from the bottom up.
     */
    public function cleanUpChildren() :void
    {
      recurseCleanChildren( _target );
    }

    /**
     * Added recursive display object removal, just to be sure everything's removed from the end leaf on up the display list.
     * @param $dispObj  the display object getting swept in the loop.
     */
    public function recurseCleanChildren( $dispObj :* ) :void
    {
      if( !( $dispObj is DisplayObjectContainer ) ) return;
      var doc :DisplayObjectContainer = $dispObj as DisplayObjectContainer;

      while ( doc.numChildren > 0 )
      {
        var obj :DisplayObject = doc.getChildAt( 0 );

        if( obj is MovieClip ) MovieClip( obj ).stop();

        if( obj is Bitmap && Bitmap( obj ).bitmapData ) Bitmap( obj ).bitmapData.dispose();

        if( obj is Loader )
        {
          cleanUpConnection( Loader( obj ) );
          doc.removeChild( obj );
          return;
        }
        else
        {
          recurseCleanChildren( obj );
          doc.removeChild( obj );
        }
        // use try/catch instead of IDisposable so that we can define dispose in timeline code: if( !( obj is IDisposable ) ) { try { ( obj as Object ).dispose(); } catch ( err:* ) {} }
      }
    }

    /**
     * Add a connection to it's <code>Dictionary</code>.
     * @param $connection the connection object to add.
     */
    public function addConnection( $connection :Object ) :void
    {
      if( !_connections ) _connections = new Dictionary( true );
      _connections[ $connection ] = true;
    }

    /**
     * Remove a connection from it's <code>Dictionary</code>.
     * @param $connection the connection object to remove.
     */
    public function removeConnection( $connection :Object ) :void
    {
      if( !_connections ) return;
      delete( _connections[ $connection ] );
    }

    /**
     * Cleans up all connections in it's <code>Dictionary</code>.
     */
    public function cleanUpConnections() :void
    {
      for( var obj :Object in _connections )
      {
        cleanUpConnection( obj );
        removeConnection( obj );
      }
    }

    /**
     * Cleans up a connection using a series of <code>try catch</code> statements.
     * <p>Skinner note: because we're unsure what type of connection we have, and what it's status is, we have to use try catch.</p>
     * @param $connection an open connection.
     */
    protected function cleanUpConnection( $connection :Object ) :void
    {
      try
      {
        var content :Object = $connection[ 'content' ];
        if( content is IDisposable ) IDisposable( content ).dispose();
      } catch( e1:* ) {}
      try
      {
//        connection.close();
        $connection[ 'close' ].apply( $connection );
      } catch( e2:* ) {}
      try
      {
//        connection.unload();
        $connection[ 'unload' ].apply( $connection );
      } catch( e3:* ) {}
      try
      {
//        connection.cancel();
        $connection[ 'cancel' ].apply( $connection );
      } catch( e4:* ) {}
    }

    /**
     * Adds the arguments of <code>IDisposables</code> to the <code>Dictionary</code>.
     * @param disposables an "<em>n</em>" number of disposables.
     */
    public function addDisposables( ...disposables ) :void
    {
      var da :Array = disposables;
      var dl :uint = da.length;
      for( var i :uint = 0; i < dl; i++ )
      {
        var disposable:IDisposable = IDisposable( da[ i ] );
        addDisposable( disposable );
      }
    }

    /**
     * Adds an <code>IDisposable</code> to it's <code>Dictionary</code>.
     * @param $disposable an <code>IDisposable</code> object to add.
     */
    public function addDisposable( $disposable :IDisposable ) :void
    {
      if( !_disposables ) _disposables = new Dictionary( true );
      _disposables[ $disposable ] = true;
    }

    /**
     * Removes an <code>IDisposable</code> from it's <code>Dictionary</code> and does not call it's <code>dispose()</code> function.
     * @param $disposable an <code>IDisposable</code> object to remove.
     */
    public function removeDisposable( $disposable :IDisposable ) :void
    {
      if( !_disposables ) return;
      delete( _disposables[ $disposable ] );
    }

    /**
     * Call the <code>dispose()</code> method on the <code>IDisposable</code> and remove it from the <code>Dictionary</code>.
     * @param $disposable an <code>IDisposable</code> object to cleanup.
     */
    public function cleanUpDisposable( $disposable :IDisposable ) :void
    {
      if( !_disposables ) return;
      ( IDisposable( $disposable ) ).dispose();
      delete( _disposables[ $disposable ] );
    }

    /**
     * Cleans up all <code>IDisposables</code> in it's <code>Dictionary</code> by calling <code>dispose()</code> on them.
     */
    public function cleanUpDisposables() :void
    {
      for( var disposable :Object in _disposables )
      {
        ( IDisposable( disposable ) ).dispose();
        removeDisposable( IDisposable( disposable ) );
      }
    }

    /**
     * Adds a <code>Timer</code> to it's <code>Dictionary</code>.
     * @param $timer  the <code>Timer</code> object to add.
     */
    public function addTimer( $timer :Timer ) :void
    {
      if( !_timers ) _timers = new Dictionary( true );
      _timers[ $timer ] = true;
    }

    /**
     * Removes a <code>Timer</code> from it's <code>Dictionary</code> but not from existance.
     * @param $timer  the <code>Timer</code> object to remove.
     */
    public function removeTimer( $timer :Timer ) :void
    {
      if( !_timers ) return;
      delete( _timers[ $timer ] );
    }

    /**
     * Removes a <code>Timer</code> from it's <code>Dictionary</code> and stop it.
     * @param $timer  the <code>Timer</code> object to remove and <code>stop()</code>.
     */
    public function cleanUpTimer( $timer :Timer ) :void
    {
      if( !_timers ) return;
      Timer( $timer ).stop();
      delete( _timers[ $timer ] );
    }

    /**
     * Cleans up all timers in it's <code>Dictionary</code> by calling <code>stop()</code> on them.
     */
    public function cleanUpTimers() :void
    {
      for( var timer :Object in _timers )
      {
        Timer( timer ).stop();
        delete( _timers[ timer ] );
      }
    }

    /**
     * If the target is a movie clip, halt the timeline.
     */
    public function cleanUpTarget() :void
    {
      if( _target is MovieClip )
        MovieClip( _target ).stop();
    }
  }
}



package com.factorylabs.orange.core.net
{
  import com.factorylabs.orange.core.IDisposable;

  import org.osflash.signals.Signal;

  import flash.display.DisplayObject;
  import flash.events.ErrorEvent;
  import flash.events.Event;
  import flash.events.IEventDispatcher;
  import flash.events.IOErrorEvent;
  import flash.events.ProgressEvent;
  import flash.events.SecurityErrorEvent;
  import flash.media.Sound;
  import flash.media.SoundLoaderContext;
  import flash.net.URLRequest;
  import flash.net.URLVariables;
  import flash.system.LoaderContext;
  import flash.utils.ByteArray;
  import flash.utils.getTimer;

  /**
   * Provides a simple to use API which serves to simplify the loading of external binary data.
   *
   * <p>LoadItems act as "wrapper" classes for Loader objects. It performs common calculations for
   * percent loaded, bandwidth, latency and remaining and total time. Also makes it easy to
   * start, pause, stop, and cancel a load operation. Runtime errors are also facilitated by
   * using LoadItems because no events dispatched from the Loader class go unhandled.</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    grantdavis
   * @version   1.0.0 :: Feb 17, 2010
   */
  public class LoadItem
    implements IDisposable
  {
    /**
     * Constant which identifies the <code>LoadItem</code> load type as a display object.
     */
    public static const TYPE_DISPLAY      :String = "LoadItemType.display";

    /**
     * Constant which identifies the <code>LoadItem</code> load type as a text file.
     */
    public static const TYPE_TEXT       :String = "LoadItemType.text";

    /**
     * Constant which identifies the <code>LoadItem</code> load type as a sound file.
     */
    public static const TYPE_SOUND        :String = "LoadItemType.sound";

    /**
     * Constant which describes the <code>LoadItem</code> idle state.
     */
    public static const STATE_IDLE        :String = "LoadItemState.idle";

    /**
     * Constant which describes the <code>LoadItem</code> connecting state.
     */
    public static const STATE_CONNECTING    :String = "LoadItemState.connecting";

    /**
     * Constant which describes the <code>LoadItem</code> open state.
     */
    public static const STATE_OPEN        :String = "LoadItemState.open";

    /**
     * Constant which describes the <code>LoadItem</code> paused state.
     */
    public static const STATE_PAUSED      :String = "LoadItemState.paused";

    /**
     * Constant which describes the <code>LoadItem</code> complete state.
     */
    public static const STATE_COMPLETE      :String = "LoadItemState.complete";

    /**
     * Constant which describes the <code>LoadItem</code> error state.
     */
    public static const STATE_ERROR       :String = "LoadItemState.error";

    /**
     * @private
     */
    private var _stateSignal          :Signal;
    /**
     * @private
     */
    private var _idleSignal           :Signal;
    /**
     * @private
     */
    private var _connectingSignal       :Signal;
    /**
     * @private
     */
    private var _pausedSignal         :Signal;
    /**
     * @private
     */
    private var _completeSignal         :Signal;
    /**
     * @private
     */
    private var _openSignal           :Signal;
    /**
     * @private
     */
    private var _progressSignal         :Signal;
    /**
     * @private
     */
    private var _initSignal           :Signal;
    /**
     * @private
     */
    private var _errorSignal          :Signal;

    /**
     * @private
     */
    protected var _signal :Signal;

    /**
     * The URLRequest object associated with this download.
     * @private
     */
    private var _request:URLRequest;

    /**
     * A LoaderContext object associated with this load.
     * @private
     */
    private var _context:LoaderContext;

    /**
     * A custom Loader subclass to use as a substitute for the default Loader class. Class MUST be a subclass of Loader.
     * @private
     */
    private var _customLoader:ILoader;

    /**
     * String value which stores this object's current LoadState value.
     * @private
     */
    private var _state:String;

    /**
     * Number value from 0-1 indicated the percent of bytes which have been loaded.
     * @private
     */
    private var _percentLoaded:Number;

    /**
     * Number of bytes remaining to load.
     * @private
     */
    private var _bytesRemaining:int;

    /**
     * Current number of bytes loaded.
     * @private
     */
    private var _bytesLoaded:int;

    /**
     * Current number of bytes total.
     * @private
     */
    private var _bytesTotal:int;

    /**
     * Number of bytes which have already been loaded before pause() was called.
     * @private
     */
    private var _bytesCached:int;

    /**
     * Number to track the bytes which have been loaded. This is calculated by the current bytes loaded minus the bytes cached.
     * @private
     */
    private var _lastByteCheck:int;

    /**
     * Number which tracks when the last byte update occured, in miliseconds. Used to calculate bandwidth.
     * @private
     */
    private var _lastUpdateTime:int;

    /**
     * Number of Kbps downloaded per second.
     * @private
     */
    private var _bandwidth:int;

    /**
     * Average latency of this load, in miliseconds.
     * @private
     */
    private var _latency:int;

    /**
     * Keeps track of when the initial start() method is called and
     * records a true starting time for the entire load.
     * @private
     */
    private var _originalStartTime:int;

    /**
     * Keeps track of whether or not the load is paused
     */
    private var _paused :Boolean;
    /**
     * Keeps track of the time at which start() was called.
     * @private
     */
    private var _startTime:int;
    /**
     * Records how long the item has been paused for.
     * Used to calculate time spent loading.
     * @private
     */
    private var _pausedTime:int;

    /**
     * Records when pause() was called and is used to calculate the time paused.
     * @private
     */
    private var _pauseStartTime:int;

    /**
     * Determines which type of content will be loaded by this LoadItem. Allowed values are specified constants from the LoadType class.
     * @private
     */
    private var _contentType : String;

    /**
     * ILoader object which performs the loading of external data.
     * @private
     */
    private var _loader : ILoader;

    /**
     * The SoundContext object to use when loading a sound. Used when the content type is set to TYPE_SOUND.
     * @private
     */
    private var _soundContext : SoundLoaderContext;

    /**
     * @return the <code>Signal</code> object that notifies listeners state changes.
     */
    public function get stateSignal() :Signal { return _stateSignal; }

    /**
     * @return the <code>Signal</code> object that notifies listeners when the <code>LoadItem</code> enters an idle state.
     */
    public function get idleSignal() :Signal { return _idleSignal; }

    /**
     * @return the <code>Signal</code> object that notifies listeners when the <code>LoadItem</code> enters an connecting state.
     */
    public function get connectingSignal() :Signal { return _connectingSignal; }

    /**
     * @return the <code>Signal</code> object that notifies listeners when the <code>LoadItem</code> enters an paused state.
     */
    public function get pausedSignal() :Signal { return _pausedSignal; }

    /**
     * @return the <code>Signal</code> object that notifies listeners when the <code>LoadItem</code> successfully completes a load.
     */
    public function get completeSignal() :Signal { return _completeSignal; }

    /**
     * @return the <code>Signal</code> object that notifies listeners when the <code>LoadItem</code> opens a connection.
     */
    public function get openSignal() :Signal { return _openSignal; }

    /**
     * @return the <code>Signal</code> object that notifies listeners when the <code>LoadItem</code> bytes are received.
     */
    public function get progressSignal() :Signal { return _progressSignal; }

    /**
     * @return the <code>Signal</code> object that notifies listeners when the <code>LoadItem</code> enters an init state.
     */
    public function get initSignal() :Signal { return _initSignal; }

    /**
     * @return the <code>Signal</code> object that notifies listeners when the <code>LoadItem</code> encounters an error.
     */
    public function get errorSignal() :Signal { return _errorSignal; }

    /**
     * @return  the current state value for this LoadItem.
     */
    public function get state():String { return ( _state ); }

    /**
     * @return  a boolean value indicating if the load is current paused (<code>true</code>).
     */
    public function get paused() :Boolean { return _paused; }

    /**
     * @return  the ILoader instance loading the external data.
     */
    public function get loader():ILoader
    {
      return _loader;
    }

    /**
     * @return  the URLRequest instance associated with this class.
     */
    public function get request():URLRequest
    {
      return _request;
    }

    /**
     * @return  the LoaderContext instance associated with this class.
     */
    public function set context( $value:LoaderContext ):void
    {
      _context = $value;
    }

    /**
     * @return  the latency of this connection, in miliseconds.
     */
    public function get latency():int
    {
      return _latency;
    }

    /**
     * @return  an integer value of the number of bytes remaining to load.
     */
    public function get bytesRemaining():int
    {
      return _bytesRemaining;
    }

    /**
     * @return an integer value of the number of bytes total to load.
     */
    public function get bytesTotal():int
    {
      return _bytesTotal;
    }
    /**
     * @return an integer value of the number of bytes loaded.
     */
    public function get bytesLoaded():int
    {
      return _bytesLoaded;
    }

    /**
     * @return  the percent of bytes loaded by this object, from 0-1.
     */
    public function get percentLoaded():Number
    {
      return _percentLoaded;
    }

    /**
     * @return  the current Kbps rate for this download.
     */
    public function get bandwidth():int
    {
      return _bandwidth;
    }

    /**
     * @return  the total time passed since this load has started, in seconds.
     */
    public function get totalTime():Number
    {
      return LoadItem.truncateNumber(( getTimer() - _originalStartTime - _pausedTime ) / 1000, 2 );
    }

    /**
     * @return  the estimated number of seconds remaining to completely load.
     */
    public function get remainingTime():Number
    {
      var bytesLoadedPerSecond:Number = _bytesLoaded / this.totalTime;
      var remainingSeconds:Number = _bytesRemaining / bytesLoadedPerSecond;
      return LoadItem.truncateNumber( remainingSeconds, 2 );
    }

    /**
     * @return  the LoaderContext instance associated with this class. Available when LoadType.SOUND is used.
     */
    public function set soundContext( $value:SoundLoaderContext ):void
    {
      _soundContext = $value;
    }

    /**
     * @return  the Sound object used to load an external sound file. Available when LoadType.SOUND is used.
     */
    public function get soundContent() : Sound
    {
      return _loader.data as Sound;
    }

    /**
     * @return  A string of an externally loaded text file. Available when LoadType.TEXT is used.
     */
    public function get textContent() : String
    {
      return _loader.data as String;
    }

    /**
     * @return  A ByteArray object. Available when LoadItem.dataFormat is set to URLLoaderDataFormat.BINARY
     */
    public function get binaryContent() : ByteArray
    {
      return _loader.data as ByteArray;
    }

    /**
     * @return  A URLVariables object. Available when the LoadItem.dataFormat is set to URLLoaderDataFormat.VARIABLES
     */
    public function get variablesContent() : URLVariables
    {
      return _loader.data as URLVariables;
    }

    /**
     * @return  The DisplayObject object. Available when LoadType.DISPLAY is used.
     */
    public function get displayContent() : DisplayObject
    {
      return _loader.data as DisplayObject;
    }

    /**
     * @return  The current data format being used for text content. This is available when LoadType.TEXT is used.
     */
    public function get dataFormat() : String
    {
      return ( _loader as TextLoader).dataFormat;
    }

    /**
     * Sets the URLLoader.dataFormat property when using LoadType.TEXT.
     * @param v_dataFormat  The URLLoaderDataFormat constant to use.
     */
    public function set dataFormat( $dataFormat : String ) : void
    {
      ( _loader as TextLoader).dataFormat = $dataFormat;
    }


    /**
     * Creates a new LoadItem instance.
     *
     * @param request   the URLRequest object to associate with this load.
     * @param priority    [Optional] the priority value to be used by this LoadItem. Used by the LoaderManager.
     * @param LoaderType  [Optional] a subclass of Loader to use for loading this item.
     */
    public function LoadItem( $request:URLRequest, $contentType: String = TYPE_DISPLAY, $customLoader:ILoader=null )
    {
      _request = $request;
      _contentType = $contentType;
      _customLoader = $customLoader;
      initialize();
    }

    /**
     * Begins the load operation.
     */
    public function start():void
    {
      _startTime = getTimer();

      if ( !_originalStartTime )
        _originalStartTime = _startTime;

      if ( _paused )
      {
        _paused = false;
        var prevPauseTime:int = _pausedTime;
        _pausedTime = _startTime -  _pauseStartTime + prevPauseTime;
      }

      _bytesCached = _bytesLoaded;
      updateByteTotal();
      load();
      setState( STATE_CONNECTING );
      _connectingSignal.dispatch( this );
    }

    /**
     * Pauses the loading of this item.
     */
    public function pause():void
    {
      updateByteTotal();
      close();
      _paused = true;
      _pauseStartTime = getTimer();
      _bytesCached = _bytesLoaded;
      setState( STATE_PAUSED );
      _pausedSignal.dispatch( this );
    }

    /**
     * Stops the loading of this item.
     */
    public function stop():void
    {
      updateByteTotal();
      close();
      _bytesCached = _bytesLoaded;
      setState( STATE_IDLE );
      _idleSignal.dispatch( this );
    }

    /**
     * @return  The string value of this class.
     */
    public function toString():String
    {
      return "[LoadItem] request: " + _request.url;
    }

    /**
     * Performs cleanup and destroy operations to prepare this class for garbage collection.
     */
    public function dispose():void
    {
      _idleSignal.removeAll();
      _openSignal.removeAll();
      _initSignal.removeAll();
      _stateSignal.removeAll();
      _errorSignal.removeAll();
      _pausedSignal.removeAll();
      _completeSignal.removeAll();
      _progressSignal.removeAll();
      _connectingSignal.removeAll();

      removeListeners( _loader.dispatcher );
      close();

      _loader = null;
      _stateSignal = null;
      _idleSignal = null;
      _connectingSignal = null;
      _pausedSignal = null;
      _completeSignal = null;
      _openSignal = null;
      _initSignal = null;
      _progressSignal = null;
      _errorSignal = null;
    }

    /**
     * Performs default initializations when first constructing the class.
     */
    protected function initialize():void
    {
      _pauseStartTime = getTimer();
      _pausedTime =
      _bytesCached =
      _percentLoaded =
      _bytesLoaded =
      _bytesTotal =
      _bytesRemaining = 0;
      _paused = false;
      _state = STATE_IDLE;
      buildSignals();
      buildLoader();
    }

    /**
     * Creates the signal objects for events and state changes.
     */
    protected function buildSignals() :void
    {
      _stateSignal      = new Signal( LoadItem, String );
      _idleSignal       = new Signal( LoadItem );
      _connectingSignal     = new Signal( LoadItem );
      _pausedSignal       = new Signal( LoadItem );
      _completeSignal     = new Signal( LoadItem );
      _openSignal       = new Signal( LoadItem );
      _initSignal       = new Signal( LoadItem );
      _progressSignal     = new Signal( LoadItem, uint, uint );
      _errorSignal      = new Signal( LoadItem, String );
    }

    /**
     * Creates the proper loader object for the content type being loaded.
     */
    protected function buildLoader() : void
    {
      switch ( _contentType )
      {
        case TYPE_DISPLAY:
          _loader = _customLoader || new DisplayLoader();
          break;

        case TYPE_TEXT:
          _loader = _customLoader || new TextLoader();
          break;

        case TYPE_SOUND:
          _loader = _customLoader || new SoundLoader();
          break;
      }
      addListeners( _loader.dispatcher );
    }


    protected function load() : void
    {
      switch ( _contentType )
      {
        case TYPE_SOUND:
          _loader.open( _request, _soundContext );
          break;

        default:
          _loader.open( _request, _context );
          break;
      }
    }

    /**
     * Attempts to close the Loader object's server connection.
     */
    protected function close():void
    {
      // if we're loading a sound, the SoundLoader rebuilds the Sound object
      // once close() is called, so we have to setup our listeners again.
      if ( _contentType == TYPE_SOUND )
      {
        removeListeners( _loader.dispatcher );
        _loader.close();
        addListeners( _loader.dispatcher );
      }
      else _loader.close();
    }

    /**
     * Adds listeners to the specified loader object.
     * @param loader  Loader to add listeners to.
     */
    protected function addListeners( $loader:IEventDispatcher ):void
    {
      $loader.addEventListener( Event.OPEN, onOpen, false, 0, true );
      $loader.addEventListener( Event.UNLOAD, onUnload, false, 0, true );
      $loader.addEventListener( Event.INIT, onLoadInit, false, 0, true );
      $loader.addEventListener( Event.COMPLETE, onLoadComplete, false, 0, true );
      $loader.addEventListener( ProgressEvent.PROGRESS, onProgress, false, 0, true );
      $loader.addEventListener( IOErrorEvent.IO_ERROR, onError, false, 0, true );
      $loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onError, false, 0, true );
    }

    /**
     * Removes loader listeners from the specified loader object.
     * @param loader Loader to remove listeners from.
     */
    protected function removeListeners( $loader:IEventDispatcher ):void
    {
      $loader.removeEventListener( Event.OPEN, onOpen );
      $loader.removeEventListener( Event.UNLOAD, onUnload );
      $loader.removeEventListener( Event.INIT, onLoadInit );
      $loader.removeEventListener( Event.COMPLETE, onLoadComplete );
      $loader.removeEventListener( ProgressEvent.PROGRESS, onProgress );
      $loader.removeEventListener( IOErrorEvent.IO_ERROR, onError );
      $loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onError );
    }

    /**
     * Sets the internal state of for this LoadItem.
     * @param value String literal defining the state of this item. Typically these states are defined in the LoadState class.
     */
    protected function setState( $value:String ):void
    {
      _state = $value;
      _stateSignal.dispatch( this, $value );
    }


    /**
     * Internally updates the byte totals and bandwidth after a progress event.
     */
    protected function updateByteTotal():void
    {
      var curBytesLoaded:int = ( !isNaN( _loader.bytesLoaded )) ? _loader.bytesLoaded : 0;
      var curBytesTotal:int = ( !isNaN( _loader.bytesTotal )) ? _loader.bytesTotal : 0;

      // check to make sure we use an old bytes loaded if its greater than reported bytes loaded.
      // this should help our bandwidth numbers from being totally inflated after pausing.
      _bytesLoaded = ( curBytesLoaded > _bytesLoaded ) ? curBytesLoaded : _bytesLoaded;
      _bytesTotal = ( curBytesTotal > _bytesTotal ) ? curBytesTotal : _bytesTotal;

      _bytesRemaining = _bytesTotal - _bytesLoaded;
      _percentLoaded = ( isNaN( _bytesLoaded / _bytesTotal ) ) ? 0 : _bytesLoaded / _bytesTotal;

      _lastByteCheck = ( _bytesLoaded - _bytesCached );
      _lastUpdateTime = getTimer();
      _bandwidth = getKbps( _lastByteCheck );
    }


    /**
     * Determines the bandwidth being used by the current load.
     * @return the Kbps of the current bandwidth.
     */
    protected function getKbps( sizeInBytes:Number ):int
    {
      var elapsedTimeMS:Number = _lastUpdateTime - _startTime; // time elapsed since start loading swf
      var elapsedTime:Number = elapsedTimeMS/1000; //convert to seconds
      var sizeInBits:Number = sizeInBytes * 8; // convert Bytes to bits
      var sizeInKBits:Number = sizeInBits/1024; // convert bits to kbits
      var kbps:Number = ( sizeInKBits/elapsedTime );// * 0.93 ; // IP packet header overhead around 7%
      return int( kbps ); // return user friendly number
    }

    /**
     * Utility function to truncate a number to the given number of decimal places.
         * Number is truncated using the <code>Math.round</code> function.
         *
         * @param  The number to truncate
         * @param  The number of decimals place to preserve.
         * @return The truncated number.
         */
        public static function truncateNumber( $raw:Number, $decimals:int =2):Number
        {
           var power : int = Math.pow(10, $decimals);
           return Math.round($raw * ( power )) / power;
        }

    /**
     * Handler for when the Loader object has successfully connected to the URL.
     * @param evt   Event object from dispatching class.
     */
    protected function onOpen( $e : Event ):void
    {
      if ( !_latency ) _latency = getTimer() - _startTime;
      updateByteTotal();
      setState( STATE_OPEN );
      _openSignal.dispatch( this );
    }

    /**
     * Handler for progress events from the Loader object.
     * @param evt   Event object from dispatching class.
     */
    protected function onProgress( $e : ProgressEvent ):void
    {
      updateByteTotal( );
      _progressSignal.dispatch( this, $e.bytesLoaded, $e.bytesTotal );
    }

    /**
     * Handles an unload event which occurs when the load operation was interrupted before finished,
     * or to clear the contents of the Loader object.
     *
     * Dispatched by a LoaderInfo object whenever a loaded object is removed by using the unload()
     * method of the Loader object, or when a second load is performed by the same Loader object
     * and the original content is removed prior to the load beginning.
     * @param evt   Event object from dispatching Loader.
     */
    protected function onUnload( $e : Event ):void
    {
      _originalStartTime = NaN;
      _paused = false;
      _idleSignal.dispatch( this );
      setState( STATE_IDLE );
    }

    /**
     * Handler for init event when the properties and methods of a loaded SWF file are accessible.
     * This event is always fired prior to the complete event.
     * @param evt   Event object from dispatching Loader.
     */
    protected function onLoadInit( $e : Event ):void
    {
      _initSignal.dispatch( this );
    }

    /**
     * Dispatched when data has loaded successfully. Always occurs after the init event.
     * @param evt   Event object from dispatching Loader.
     */
    protected function onLoadComplete( $e : Event ):void
    {
      setState( STATE_COMPLETE );
      _completeSignal.dispatch( this );
    }

    /**
     * Dispatched when an input or output error occurs that causes a load operation to fail
     * @param evt   Event object from dispatching Loader.
     */
    protected function onError( $e : ErrorEvent ):void
    {
      setState( STATE_ERROR );
      _errorSignal.dispatch( this, $e.text );
    }
  }
}


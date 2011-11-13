
package com.factorylabs.orange.core.net
{
  import com.factorylabs.orange.core.IDisposable;
  import org.osflash.signals.Signal;

  import flash.display.Loader;
  import flash.display.LoaderInfo;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.ProgressEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLRequest;
  import flash.utils.getTimer;

  /**
   * Loads a specified test file and determines the users bandwidth.
   *
   * <p>The larger the file, the more accurate measurement we can achieve, but at the cost on the client side.</p>
   * <p>Thanks to <a target="_top" href="http://www.sonify.org/home/feature/remixology/019_bandwidthdetection/">Hayden Porter for writing a nice article on testing bandwidth</a>.</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Feb 12, 2010
   */
  public class BandwidthDetection
    implements IDisposable
  {
    /**
     * Constant string for the onComplete handler.
     */
    public const COMPLETE :String = 'onComplete';

    /**
     * Constant string for the onError handler.
     */
    public const ERROR    :String = 'onError';

    /**
     * @private
     */
    protected var _url    :String;

    /**
     * @private
     */
    protected var _signal :Signal;

    /**
     * @private
     */
    protected var _loader :Loader;

    /**
     * @private
     */
    protected var _start  :Number = NaN;

    /**
     * @private
     */
    protected var _end    :Number = NaN;

    /**
     * @private
     */
    protected var _result :Number = NaN;

    /**
     * The url location of the file to use to determine bandwidth.
     * <p>The larger the file, the more accurate measurement we can achieve, but at the cost on the client side.</p>
     */
    public function get url() :String { return _url; }
    public function set url( $url :String ) :void
    {
      _url = $url;
    }

    /**
     * The <code>Signal</code> used for dispatching messages on states of a load.
     */
    public function get signal() :Signal
    {
      return _signal;
    }

    /**
     * The result in <code>kbps</code> for determining bandwidth.
     */
    public function get result() :Number
    {
      return _result;
    }

    /**
     * Instantiate and ready a Bandwidth detector.
     * @param $url  The url location of the file to measure bandwidth.
     */
    public function BandwidthDetection( $url :String )
    {
      _url = $url + '?seed=' + int( Math.random() * 10000 );
      _signal = new Signal( String, Number );
      _loader = new Loader();
    }

    /**
     * @return  The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.net.BandwidthDetection';
    }

    /**
     * Add the listeners and start loading this bad boy.
     */
    public function load() :void
    {
      addListeners( _loader.contentLoaderInfo );
      _loader.load( new URLRequest( _url ) );
    }

    /**
     * @inheritDoc
     */
    public function dispose() :void
    {
      cleanUp();
      _signal.removeAll();
      _signal = null;
    }

    /**
     * Add listeners for states of the loading process.
     * @param $dipatcher  The <code>Loader.contentLoaderInfo</code> object
     */
    protected function addListeners( $dipatcher :LoaderInfo ) :void
    {
      $dipatcher.addEventListener( ProgressEvent.PROGRESS, onProgress );
      $dipatcher.addEventListener( Event.INIT, onComplete );
      $dipatcher.addEventListener( Event.UNLOAD, onError );
      $dipatcher.addEventListener( IOErrorEvent.IO_ERROR, onError );
      $dipatcher.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onError );
    }

    /**
     * Remove listeners for states of the loading process.
     * @param $dipatcher  The <code>Loader.contentLoaderInfo</code> object
     */
    protected function removeListeners( $dipatcher :LoaderInfo ) :void
    {
      $dipatcher.removeEventListener( ProgressEvent.PROGRESS, onProgress );
      $dipatcher.removeEventListener( Event.INIT, onComplete );
      $dipatcher.removeEventListener( Event.UNLOAD, onError );
      $dipatcher.removeEventListener( IOErrorEvent.IO_ERROR, onError );
      $dipatcher.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onError );
    }

    /**
     * Record the start time as soon as the bandwidth detector starts it's download.
     * @param $e  Event data assoicated with the download progress.
     */
    protected function onProgress( $e :ProgressEvent ) :void
    {
      if( isNaN( _start ) )
        _start = getTimer();
    }

    /**
     * Records the end time before dispatching the bandwidth result.
     * @param $e  Event data assoicated with the complete event.
     */
    protected function onComplete( $e :Event ) :void
    {
      _end = getTimer();
      dispatch( COMPLETE );
      cleanUp();
    }

    /**
     * Records the end time before dispatching the bandwidth result.
     * <p>It'll try and calculate a basic result if there is an error thrown.</p>
     * @param $e  Event data assoicated with the error event.
     */
    protected function onError( $e :Event ) :void
    {
      _end = getTimer();
      dispatch( ERROR );
      cleanUp();
    }

    /**
     * Formats the result and sends it out through a <code>Signal</code>.
     * @param $type The string identifier of where the result is coming from.
     */
    protected function dispatch( $type :String ) :void
    {
      var tb :Number = _loader.contentLoaderInfo.bytesTotal;
      _result = ( tb < 0 || isNaN( tb ) ) ? 0 : Math.ceil( getKbps( tb * 1.25 ) );
      _signal.dispatch( $type, _result );
    }

    /**
     * Calculates and converts elaspsed time and byte size to <code>kbps</code>.
     * @param $sizeInBytes The kbps of the current bandwidth.
     */
    protected function getKbps( $sizeInBytes :Number ) :Number
    {
      var elapsedTimeMS :Number = _end - _start;
      var elapsedTimeSecs :Number = elapsedTimeMS / 1000;
      var sizeInBits :Number = $sizeInBytes * 8;
      var sizeInKBits :Number = sizeInBits / 1024;
      var kbps :Number = ( sizeInKBits / elapsedTimeSecs );
      return Math.floor( kbps );
    }

    /**
     * Internal cleanUp for removing listeners and nulling out the <code>Loader</code>
     */
    protected function cleanUp() :void
    {
      if( _loader )
      {
        removeListeners( _loader.contentLoaderInfo );
        _loader = null;
      }
    }
  }
}


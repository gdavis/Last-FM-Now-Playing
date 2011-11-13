
package com.factorylabs.orange.core.net
{
  import org.osflash.signals.Signal;

  import flash.display.Loader;
  import flash.display.LoaderInfo;
  import flash.events.ErrorEvent;
  import flash.events.Event;
  import flash.events.HTTPStatusEvent;
  import flash.events.IEventDispatcher;
  import flash.events.IOErrorEvent;
  import flash.events.ProgressEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLRequest;
  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;
  import flash.system.SecurityDomain;

  /**
   * FLoader handles loading of display objects and uses default icons to show image load errors.
   *
   * <p>Error events are given high priority so <code>FLoader</code> can intercept these events and prevent any
   * other listeners from taking action on the unfound file. Instead, load the broken image icon and then
   * proceed as normal. For this behavior to take effect, a broken image must be provided by the contstructor.</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Grant Davis
   * @version   1.0.0 :: Nov 2, 2007
   * @version   2.0.0 :: August 14, 2008
   * @version   2.5.0 :: Feb 15, 2010 :: Added Signal dispatching and instituted passing in a broken image instead of relying on a global const.
   */
  public class FLoader
    extends Loader
      implements ILoader
  {
    /**
     * @private
     */
    private static const DEFAULT_CONTEXT :LoaderContext = new LoaderContext( true, ApplicationDomain.currentDomain, SecurityDomain.currentDomain );

    /**
     * @private
     */
    protected var _brokenImage  :String;

    /**
     * @private
     */
    protected var _signal   :Signal;

    /**
     * Provide an optional signal for sending out events.
     */
    public function get signal() :Signal
    {
      return _signal;
    }

    /**
     * @inheritDoc
     */
    public function get dispatcher():IEventDispatcher
    {
      return contentLoaderInfo;
    }

    /**
     * @inheritDoc
     */
    public function get bytesLoaded() :int
    {
      return contentLoaderInfo.bytesLoaded;
    }

    /**
     * @inheritDoc
     */
    public function get bytesTotal() :int
    {
      return contentLoaderInfo.bytesTotal;
    }

    /**
     * @inheritDoc
     */
    public function get data() :*
    {
      return super.content;
    }

    /**
     * Get or set the location for utilizing a broken image icon if there is an error while trying to load an image.
     */
    public function get brokenImage() :String { return _brokenImage; }
    public function set brokenImage( $brokenImage :String ) :void
    {
      _brokenImage = $brokenImage;
    }

    /**
     * Instantiate the loader with an optional broken image icon for handling errors.
     * @param $brokenImage  The location of the broken image icon for the loader to class to use on errors.
     */
    public function FLoader( $brokenImage :String = null)
    {
      super();
      _signal = new Signal( String, LoaderInfo );
      _brokenImage = $brokenImage;
      addListeners();
    }

    /**
     * @return The string equivalent of this class.
     */
    override public function toString() :String
    {
      return 'com.factorylabs.orange.core.net.FLoader';
    }

    /**
     * @inheritDoc
     */
    public function open( $request :URLRequest, $context :* = null ) :void
    {
      if( $context == null )
        $context = DEFAULT_CONTEXT;
      super.load( $request, LoaderContext( $context ) );
    }

    /**
     * @inheritDoc
     */
    override public function close() :void
    {
      try{ super.close(); }
      catch( e:* ) {}
    }

    /**
     * Methods which sets the loader to listen for error events.
     * Error events are added with high priority.
     */
    protected function addListeners() :void
    {
      contentLoaderInfo.addEventListener( Event.OPEN, onEvent );
      contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, onEvent );
      contentLoaderInfo.addEventListener( Event.COMPLETE, onEvent );
      contentLoaderInfo.addEventListener( Event.INIT, onComplete );
      contentLoaderInfo.addEventListener( HTTPStatusEvent.HTTP_STATUS, onEvent );
      contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onError, false, 999 );
      contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onError, false, 999 );
      contentLoaderInfo.addEventListener( Event.UNLOAD, onComplete );
    }

    /**
     * Removes listeners from content info.
     */
    protected function removeListeners() :void
    {
      contentLoaderInfo.removeEventListener( Event.OPEN, onEvent );
      contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, onEvent );
      contentLoaderInfo.removeEventListener( Event.COMPLETE, onEvent );
      contentLoaderInfo.removeEventListener( Event.INIT, onComplete );
      contentLoaderInfo.removeEventListener( HTTPStatusEvent.HTTP_STATUS, onEvent );
      contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onError );
      contentLoaderInfo.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onError );
      contentLoaderInfo.removeEventListener( Event.UNLOAD, onComplete );
    }

    /**
     * Uses a signal to dispatch the event.
     * @param $e  Event sent through the contentLoaderInfo
     */
    protected function onEvent( $e :Event ) :void
    {
      _signal.dispatch( $e.type, contentLoaderInfo );
    }

    /**
     * Removes event listeners after a successful load or a load that was aborted before finished.
     * @param $e  Event object from dispatching class.
     */
    protected function onComplete( $e :Event ) :void
    {
      removeListeners();
      onEvent( $e );
    }

    /**
     * This handler intercepts the ErrorEvent and prevents it from propigating to other listeners.
     * <p>From here it will attempt to load the broken image icon if one was supplied. We want to intercept the
     * error in the event that this ImageLoader is being used in a queue, it won't hear the error and will continue
     * with normal load process after the broken image icon is loaded. Remove error handling on first error.
     * Subsequent errors will need to be handled by the listening classes as normal. i.e. if we fail to load the
     * broken image icon, we're just damn outta luck and need a runtime error to be thrown.</p>
     * @param $e  Event object from dispatching class.
     */
    protected function onError( $e :ErrorEvent ) :void
    {
      contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onError );
      contentLoaderInfo.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onError );
      $e.stopImmediatePropagation();
      if( _brokenImage )
        load( new URLRequest( _brokenImage ));
    }
  }
}



package com.factorylabs.orange.core.net
{
  import flash.events.IEventDispatcher;
  import flash.media.Sound;
  import flash.media.SoundLoaderContext;
  import flash.net.URLRequest;

  /**
   * Compositional wrapper for loading Sound via an ILoader.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Grant Davis
   * @version   1.0.0 :: Aug 14, 2008
   */
  public class SoundLoader
    implements ILoader
  {
    /**
     * @private
     */
    private static const DEFAULT_CONTEXT  :SoundLoaderContext = new SoundLoaderContext( 1000, true );

    /**
     * @private
     */
    protected var _loader :Sound;

    /**
     * @inheritDoc
     */
    public function get dispatcher() :IEventDispatcher
    {
      return _loader;
    }

    /**
     * @inheritDoc
     */
    public function get bytesLoaded() :int
    {
      return _loader.bytesLoaded;
    }

    /**
     * @inheritDoc
     */
    public function get bytesTotal() :int
    {
      return _loader.bytesTotal;
    }

    /**
     * @inheritDoc
     */
    public function get data() :*
    {
      return _loader;
    }

    public function SoundLoader()
    {
      _loader = new Sound();
    }

    /**
     * @return The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.net.SoundLoader';
    }

    /**
     * @inheritDoc
     */
    public function open( $request :URLRequest, $context :* = null ) :void
    {
      if ( $context == null ) $context = DEFAULT_CONTEXT;
      _loader.load( $request, SoundLoaderContext( $context ) );
    }

    /**
     * @inheritDoc
     */
    public function close():void
    {
      try{ _loader.close(); }
      catch( e:* ){};
      _loader = new Sound();
    }
  }
}



package com.factorylabs.orange.core.net
{
  import flash.display.Loader;
  import flash.events.IEventDispatcher;
  import flash.net.URLRequest;
  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;
  import flash.system.SecurityDomain;

  /**
   * Basic class for loading display content (i.e. JPGs, GIFs, SWFs).
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
  public class DisplayLoader
    implements ILoader
  {
    /**
     * @private
     */
    private static const DEFAULT_CONTEXT :LoaderContext = new LoaderContext( true, ApplicationDomain.currentDomain, SecurityDomain.currentDomain );

    /**
     * @private
     */
    protected var _loader :Loader;

    /**
     * @inheritDoc
     */
    public function get dispatcher() :IEventDispatcher
    {
      return _loader.contentLoaderInfo;
    }

    /**
     * @inheritDoc
     */
    public function get bytesLoaded() :int
    {
      return _loader.contentLoaderInfo.bytesLoaded;
    }

    /**
     * @inheritDoc
     */
    public function get bytesTotal() :int
    {
      return _loader.contentLoaderInfo.bytesTotal;
    }

    /**
     * @inheritDoc
     */
    public function get data() :*
    {
      return _loader.content;
    }

    public function DisplayLoader()
    {
      _loader =  new Loader();
    }

    /**
     * @return The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.net.DisplayLoader';
    }

    /**
     * @inheritDoc
     */
    public function open( $request :URLRequest, $context :* = null ) :void
    {
      if ( $context == null ) $context = DEFAULT_CONTEXT;
      _loader.load( $request, LoaderContext( $context ));
    }

    /**
     * @inheritDoc
     */
    public function close():void
    {
      try{ _loader.close(); }
      catch( e:* ){};
    }
  }
}


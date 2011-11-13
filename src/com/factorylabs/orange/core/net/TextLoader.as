
package com.factorylabs.orange.core.net
{
  import flash.events.IEventDispatcher;
  import flash.net.URLLoader;
  import flash.net.URLRequest;

  /**
   * Compositional wrapper for loading text via an ILoader.
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
  public class TextLoader
    implements ILoader
  {
    /**
     * @private
     */
    protected var _loader :URLLoader;

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
      return _loader.data;
    }

    /**
     * The data format used by the URLLoader.
     */
    public function get dataFormat() :String { return _loader.dataFormat; }
    public function set dataFormat( $dataFormat :String ) :void
    {
      _loader.dataFormat = $dataFormat;
    }

    /**
     * Create a URLLoader compositionally.
     */
    public function TextLoader()
    {
      _loader = new URLLoader();
    }

    /**
     * @return  The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.net.TextLoader';
    }

    /**
     * @inheritDoc
     */
    public function open( $request :URLRequest, context :* = null ) :void
    {
      _loader.load( $request );
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


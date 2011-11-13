
package com.factorylabs.orange.core.net
{
  import flash.events.IEventDispatcher;
  import flash.net.URLRequest;

  /**
   * Interface which provides a common API among all objects that externally load data.
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
  public interface ILoader
  {
    /**
     * Reference to the event dispatcher object that will dispatch load notification events.
     */
    function get dispatcher() :IEventDispatcher;

    /**
     * Returns the number of bytes that have been loaded by the Loader.
     */
    function get bytesLoaded() :int;

    /**
     * Returns the number of totaly bytes in the file being loaded by the Loader.
     */
    function get bytesTotal() :int;

    /**
     * Return an untyped object representing the data loaded by the loader.
     */
    function get data() :*;

    /**
     * Opens a connection to a specified URL to load data from.
     * @param $request  URLRequest of the file to load.
     * @param $context  Context for the load to execute in.
     */
    function open( $request :URLRequest, $context :* = null ) :void;

    /**
     * Attempts to close the loader connection.
     */
    function close() :void;
  }
}


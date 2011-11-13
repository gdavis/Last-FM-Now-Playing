
package com.factorylabs.orange.core.gc
{
  import com.factorylabs.orange.core.collections.IMap;

  /**
   * Provides an interface for storing a number of <code>Janitor</code> instances for quick and automated cleanup.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Nov 22, 2009
   */
  public interface IJanitorManager
  {
    /**
     * The <code>IMap</code> to store all <code>IJanitor</code> instances.
     */
    function get map() :IMap;

    /**
     * Adds a <code>Janitor</code> instance to the <code>IJanitor</code>'s <code>IMap</code>.
     * @param $janitor  <code>IJanitor</code> to add.
     */
    function addJanitor( $janitor :IJanitor ) :void;

    /**
     * Removes a <code>IJanitor</code> instance from the <code>IMap</code>.
     * @param $janitor  <code>IJanitor</code> to remove.
     */
    function removeJanitor( $janitor :IJanitor ) :void;

    /**
     * Explicitly remove and call the cleanup for an <code>IJanitor</code>.
     * @param $janitor  <code>IJanitor</code> to remove.
     */
    function cleanUpJanitor( $janitor :IJanitor ) :void;

    /**
     * Cleans up all <code>IJanitors</code> registered to the manager.
     */
    function cleanUp() :void;
  }
}


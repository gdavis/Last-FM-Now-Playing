
package com.factorylabs.orange.core.gc
{
  /**
   * Provides an interface with a public <code>cleanUp()</code> method.
   *
   * <p>This interface allows implementing classes to adhere to the standard
   * <code>cleanUp()</code> method which is called when a <code>Janitor</code> is preparing an object for garbage collection</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: March 6, 2009
   */
  public interface IJanitor
  {
    /**
     * Prepares an <code>IJanitor</code> object for garbage collection.
     */
    function cleanUp() :void;
  }
}


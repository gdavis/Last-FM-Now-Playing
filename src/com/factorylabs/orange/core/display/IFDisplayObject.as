
package com.factorylabs.orange.core.display
{
  /**
   * Basic implementations for all <code>FDisplayObjects</code> which are subclasses of the native <code>DisplayObjects</code>.
   *
   * <p>Meant to be used in place of the native flash <code>DisplayObject</code> class.</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Nov 27, 2009
   */
  public interface IFDisplayObject
  {
    /**
     * Maps all the object's properties to the <code>DisplayObject</code>.
     * <p>If there are properties that do not exist, an error is thrown.</p>
     * @param $object Object to map properties from.
     * @throws  ArgumentError <code>ArgumentError</code> When an invalid property assignment was attempted.
     */
    function setProperties( $object :Object ) :void;

    /**
     * Removes the display object from its parent container.
     */
    function remove() :void;
  }
}


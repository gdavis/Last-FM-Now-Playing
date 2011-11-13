
package com.factorylabs.orange.core.gc
{
  import flash.utils.Dictionary;

  /**
   * Enables WeakReference for the garbage collector.
   *
   * <p>The following people are credited with originating all or parts of this code:<br />
   * Grant Skinner :: www.gskinner.com</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Grant Skinner
   * @author    Ryan Boyajian
   * @version   1.0.0 :: Aug 19, 2008
   */
  public final class WeakReference
  {
    private var dictionary:Dictionary;

    /**
     * Setup a weak reference.
     * @param $obj  The object to utilize a weak reference.
     */
    public function WeakReference( $obj :* )
    {
      dictionary = new Dictionary( true );
      dictionary[ $obj ] = null;
    }

    /**
     * The objects residing in the <code>Dictionary</code>.
     */
    public function get() :*
    {
      for( var n :* in dictionary ) { return n; }
      return null;
    }

    /**
     * @return  The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.gc.WeakReference';
    }
  }
}


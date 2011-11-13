
package com.factorylabs.orange.core.gc
{
  import com.factorylabs.orange.core.collections.IMap;
  import com.factorylabs.orange.core.collections.Map;

  /**
   * Used for storing a number of <code>Janitor</code> instances for quick and automated cleanup.
   *
   * <p>This class is used primarily for cleaning up a <em>.swf</em> that gets loaded and disposed of so that all references can be cleaned out.</p>
   *
   * <p>Manages all of the <code>Janitor</code> instances so that clean up can be called on everything in the app.
   * This is generally injected at the Application level.</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Ryan Boyajian
   * @version   1.0.0 :: Feb 8, 2008
   * @author    Matthew Kitt
   * @version   2.0.0 :: Nov 22, 2009
   */
  public class JanitorManager
    implements IJanitorManager
  {
    private var _map      :IMap;

    /**
     * @inheritDoc
     */
    public function get map() :IMap { return _map; }

    /**
     * Instantiation only.
     */
    public function JanitorManager()
    {
    }

    /**
     * @return  The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.gc.JanitorManager';
    }

    /**
     * @inheritDoc
     */
    public function addJanitor( $janitor :IJanitor ) :void
    {
      if( _map == null )
        _map = new Map( true );
      _map.add( $janitor, true );
    }

    /**
     * @inheritDoc
     */
    public function removeJanitor( $janitor :IJanitor ) :void
    {
      if( _map.hasKey( $janitor ) )
        _map.remove( $janitor );
    }

    /**
     * @inheritDoc
     */
    public function cleanUpJanitor( $janitor :IJanitor ) :void
    {
      removeJanitor( $janitor );
      $janitor.cleanUp();
    }

    /**
     * @inheritDoc
     */
    public function cleanUp() :void
    {
      for each( var janitor :Object in _map.keys )
      {
        IJanitor( janitor ).cleanUp();
      }
      if( _map != null )
        _map.dispose();
    }
  }
}


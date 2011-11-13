
package com.factorylabs.orange.core.display.utils
{
  import flash.display.DisplayObjectContainer;
  import flash.display.MovieClip;
  import flash.system.ApplicationDomain;

  /**
   * Global function for attaching a library symbol as MovieClip.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Justin Gitlin
   * @version   1.0.0 :: 2008
   */

  /**
   * Creates an instance of a clip from the library similar to how <code>attachMovie()</code> used to work.
   * @param $identifier The string identifier of the class to be created.
   * @param $init   Object containing init props for the attached clip.
   * @param $container  The container that the new attached clip will be added to if supplied.
   * @param $domain   The application domain to search for the object. this can be used to get library items from loaded in .swfs.
   * @return  A reference to the <code>MovieClip</code> that is attached.
   */
  public function attachMovieClip( $identifier :String, $init :Object = null, $container :DisplayObjectContainer = null, $domain :ApplicationDomain = null ) :MovieClip
  {
    var domain :ApplicationDomain = $domain || ApplicationDomain.currentDomain;
    var instance :MovieClip;

    try
    {
      var ClassRef :Class = domain.getDefinition( $identifier ) as Class;
      instance = MovieClip( new ClassRef() );
    }
    catch( $e :Error )
    {
      throw new Error( 'attachMovieClip() ' + $e );
    }

    if( instance )
    {
      if( $init )
      {
        for( var it :String in $init )
        {
          if( instance.hasOwnProperty( it ) )
            instance[ it ] = $init[ it ];
          else
            throw new ArgumentError( 'An invalid property assignment was attempted on attachMovieClip for the property ' + it );
        }
      }
      if( $container )
        $container.addChild( instance );
    }
    return instance;
  }
}


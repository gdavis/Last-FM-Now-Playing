
package com.factorylabs.orange.core.display
{
  import flash.display.DisplayObjectContainer;
  import flash.display.MovieClip;

  /**
   * FMovieClip is the base class for all <code>MovieClip</code> objects.
   *
   * <p>Utilize this class to inline and automate basic needs of a visual <code>MovieClip</code>.</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author Sean Dougherty
     * @version   1.0
     * @version   2.0.0 :: Dec 17, 2008 Took a lot of extra functionality and added it to FMovieClipExtended
   */
  public class FMovieClip
    extends MovieClip
      implements IFDisplayObject
  {
    /**
     * Reference to the object's container.
     */
    protected var _container  :DisplayObjectContainer;

    /**
     * FMovieClip is the basic building block for display objects that have timelines.
     *
     * <p>Meant to be used in place of the native flash <code>MovieClip</code> class.</p>
     *
     * @param $container The <code>DisplayObject</code> to add this <code>FMovieClip</code> to. If <code>null</code> this
     * <code>FMovieClip</code> will not automatically be added to the display tree of another <code>DisplayObject</code>.
     * @param $init Object containting all parameters to automatically asign upon instantiation.
     * @example The following code is the simplest example of how to use <code>FMovieClip</code>.
     * <listing version="3.0" >
     * // assumes holder is an existing display object
     * // mc will be added to holder's display list and set to an x and y position of 10
     * var mc:FMovieClip = new FMovieClip( _container, { x:10, y:10 } );
     * </listing>
     */
        public function FMovieClip( $container :DisplayObjectContainer = null, $init :Object = null )
    {
      super();
      tabEnabled = false;
      _container = $container;

      if( _container != null )
        _container.addChild( this );

      if( $init )
        setProperties( $init );
    }

    /**
     * @return  the string equivalent of this class.
     */
    override public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.FMovieClip';
    }

    /**
     * @inheritDoc
     */
    public function setProperties( $object :Object ) :void
    {
      for( var it :String in $object )
      {
        if( this.hasOwnProperty( it ) )
          this[ it ] = $object[ it ];
        else
          throw new ArgumentError( 'An invalid property assignment was attempted on ' + this.toString() + ' for the property ' + it );
      }
    }

    /**
     * @inheritDoc
     */
    public function remove():void
    {
      if( this.parent )
        this.parent.removeChild( this );
    }
  }
}


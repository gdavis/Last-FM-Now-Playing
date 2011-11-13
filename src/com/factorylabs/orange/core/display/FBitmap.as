
package com.factorylabs.orange.core.display
{
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObjectContainer;

  /**
   * FBitmap is the base class for all <code>Bitmap</code> objects.
   *
   * <p>Utilize this class to inline and automate basic needs of a visual <code>Bitmap</code>.</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Grant Davis
   * @version   1.0.0 :: Oct 31, 2007
   */
  public class FBitmap
    extends Bitmap
      implements IFDisplayObject
  {
    /**
     * Reference to the object's container.
     */
    protected var _container  :DisplayObjectContainer;

    /**
     * FBitmap is the basic building block for bitmap display objects.
     *
     * <p>Meant to be used in place of the native flash <code>Bitmap</code> class.</p>
     *
     * @param $container The <code>DisplayObject</code> to add this <code>FBitmap</code> to. If <code>null</code> this
     * <code>FBitmap</code> will not automatically be added to the display tree of another <code>DisplayObject</code>.
     * @param $init Object containting all parameters to automatically asign upon instantiation.
     * @example The following code is the simplest example of how to use <code>FBitmap</code>.
     * <listing version="3.0" >
     * // assumes holder is an existing display object
     * // mc will be added to holder's display list and set to an x and y position of 10
     * var mc:FBitmap = new FBitmap( _container, { x:10, y:10 } );
     * </listing>
     */
    public function FBitmap( $container :DisplayObjectContainer = null, $bmpData :BitmapData = null, $init :Object = null )
    {
      super( $bmpData );
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
      return 'com.factorylabs.orange.core.display.FBitmap';
    }

    /**
     * @inheritDoc
     */
    public function setProperties( $object :Object ) :void
    {
      for( var it :String in $object )
      {
        if( this.hasOwnProperty( it ) ) this[ it ] = $object[ it ];
        else
          throw new ArgumentError( 'An invalid property assignment was attempted on ' + this.toString() + ' for the property ' + it );
      }
    }

    /**
     * @inheritDoc
     */
    public function remove() :void
    {
      if( this.parent )
        this.parent.removeChild( this );
    }
  }
}


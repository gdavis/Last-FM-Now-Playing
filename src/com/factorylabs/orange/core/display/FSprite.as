
package com.factorylabs.orange.core.display
{
  import flash.display.DisplayObjectContainer;
  import flash.display.Sprite;

  /**
   * FSprite is the base class for all <code>Sprite</code> objects.
   *
   * <p>Utilize this class to inline and automate basic needs of a visual <code>Sprite</code>.</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Ryan Boyajian
   * @author    Sean Dougherty
   * @version   1.0.0 :: Apr 18, 2008
   * @version   2.0.0 :: Dec 17, 2008 :: Took a lot of extra functionality and added it to FSpriteExtended
   * @version   2.5.0 :: Nov 26, 2009 :: Renamed some parameters and optimize for FP 10.
   */
  public class FSprite
    extends Sprite
      implements IFDisplayObject
  {
    /**
     * Reference to the object's container.
     */
    protected var _container  :DisplayObjectContainer;

    /**
     * FSprite is the basic building block for display objects that can have mouse interaction.
     *
     * <p>Meant to be used in place of the native flash <code>Sprite</code> class.</p>
     *
     * @param $container The <code>DisplayObject</code> to add this <code>FSprite</code> to, if <code>null</code> this
     * <code>FSprite</code> will not automatically be added to the display tree of another <code>DisplayObject</code>.
     * @param $init Object containting all parameters to automatically asign upon instantiation.
     * @example The following code is the simplest example of how to use FSprite.
     * <listing version="3.0" >
     * // assumes holder is an existing display object
     * // mc will be added to contanier's display list and set to an x and y position of 10
     * var mc:FSprite = new FSprite( _container, { x:10, y:10 } );
     * </listing>
     */
    public function FSprite( $container :DisplayObjectContainer = null, $init : Object = null )
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
      return 'com.factorylabs.orange.core.display.FSprite';
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
    public function remove() :void
    {
      if( this.parent )
        this.parent.removeChild( this );
    }
  }
}


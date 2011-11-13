
package com.factorylabs.orange.core.display
{
  import flash.display.BitmapData;
  import flash.display.DisplayObjectContainer;

  /**
   * FBitmapText is an <code>FTextField</code>, immediately turned into a <code>Bitmap</code>, for performance reasons.
   *
   * <p>This class operates much in the same way as an <code>FTextField</code>, except the text is immediately turned into a <code>Bitmap</code>.</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Justin Gitlin
   * @version   1.0.0 :: Apr 18, 2008
   * @version   2.0.0 :: Dec 17, 2008 :: Removed the initialization method since it was already being called on the FTextField.
   */
  public class FBitmapText
    extends FSprite
  {
    private var _fBitmap :FBitmap;

    /**
     * The <code>FBitmap</code> object of the <code>FTextField</code> stored in this instance.
     */
    public function get fBitmap() :FBitmap { return _fBitmap; }

    /**
     * Instantiate the <code>FSprite</code> masked as a <code>TextField</code> and create a <code>Bitmap</code> snapshot of that <code>TextField</code>.
     * @param $container The <code>DisplayObject</code> to add this <code>FSprite</code> to, if <code>null</code> this
     * <code>FSprite</code> will not automatically be added to the display tree of another <code>DisplayObject</code>.
     * @param $init Object containting all parameters to automatically asign upon to the <code>FTextField</code>'s instantiation.
     * @example The following code is the simplest example of how to use FBitmapText.
     * <listing version="3.0" >
     * // assumes holder is an existing display object
     * // mc will be added to contanier's display list and set to an x and y position of 10
     * var bt:BitmapText = new FBitmapText( _container, { x:10, y:10, multiline: true, text: 'Monkey Pumper' } );
     * var bitmap :FBitmap = bt.fBitmap;
     * </listing>
     */
        public function FBitmapText( $container :DisplayObjectContainer = null, $init :Object = null, $smooth :Boolean = false )
    {
      super( $container );
      build( $init, $smooth );
    }

    /**
     * @return  the string equivalent of this class.
     */
    override public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.FBitmapText';
    }

    /**
     * Build the <code>FTextField</code>, take a snapshot, and get rid of the <code>TextField</code>.
     * @param $init   Initialization properties to set on the <code>FTextField</code>.
     * @param $smooth Whether to apply the <code>BitmapData</code>'s <code>smooth</code> property.
     */
    protected function build( $init :Object = null, $smooth :Boolean = false ) :void
    {
      var txt :FTextField = new FTextField( this, $init );
      _fBitmap = createBitmap( $smooth );
      this.removeChild( txt );
      txt = null;
    }

    /**
     * Creates the <code>FBitmap</code> snapshot of the <code>TextField</code>.
     * @param $smooth Whether to apply the <code>BitmapData</code>'s <code>smooth</code> property.
     * @return  The snapshot of the <code>FTextField</code> as a <code>FBitmap</code> object.
     */
    private function createBitmap( $smooth:Boolean = false ) :FBitmap
    {
      var bmpData :BitmapData = new BitmapData( Math.ceil( this.width ), Math.ceil( this.height ), true, 0x000000 );
      bmpData.draw( this, null, null, null, null, $smooth );
      var bmp :FBitmap = new FBitmap( this, bmpData );
      return bmp;
    }
  }
}


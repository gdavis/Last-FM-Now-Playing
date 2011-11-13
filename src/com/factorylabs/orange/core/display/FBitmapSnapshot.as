
package com.factorylabs.orange.core.display
{
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.display.DisplayObjectContainer;
  import flash.geom.Matrix;

  /**
   * Utilizes a Bimtap to take a snapshot of DisplayObject's properties and converts those into a BitmapData object.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Feb 8, 2010
   */
  public class FBitmapSnapshot
    extends Bitmap
  {
    /**
     * @inheritDoc
     */
    public function FBitmapSnapshot( $bitmapData :BitmapData = null, $pixelSnapping :String = 'auto', $smoothing :Boolean = true )
    {
      super( $bitmapData, $pixelSnapping, $smoothing );
    }

    /**
     * @return The string equivalent of this class.
     */
    override public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.FBitmapSnapshot';
    }

    /**
     * Take the snapshot of a DisplayObject in it's current state.
     * @param $source     The object to take a snapshot of.
     * @param $container    The container to render the snapshot too.
     * @param $width      The optional <code>width</code> to set the snapshot too.
     * @param $height     The optional <code>height</code> to set the snapshot too.
     * @param $transparent    Whether to render the snapshot with alpha channels.
     * @param $color      Fill color for empty pixels (used if transparency is <code>false</code>).
     * @param $matrix     Matrix to apply to the snapshot.
     * @param $autoRemoveSource Whether to attempt to remove the source of the snapshot from it's parent.
     */
    public function snapshot( $source :DisplayObject,
                  $container :DisplayObjectContainer = null,
                  $width :Number = NaN,
                  $height :Number = NaN,
                  $transparent :Boolean = true,
                  $color :int = 0xFF00FF,
                  $matrix :Matrix = null,
                  $autoRemoveSource :Boolean = false ) :void
    {
      var vw :int = ( isNaN( $width ) ) ? $source.width : $width;
      var vh :int = ( isNaN( $height ) ) ? $source.height : $height;

      var bitdata :BitmapData = new BitmapData( vw, vh, $transparent, $color );
      bitdata.draw( $source, $matrix );
      this.bitmapData = bitdata;

      if( $container )
        $container.addChild( this );

      if( $autoRemoveSource )
      {
        try
        {
          $source.parent.removeChild( $source );
        }
        catch( $e :Error ){}
      }
    }
  }
}


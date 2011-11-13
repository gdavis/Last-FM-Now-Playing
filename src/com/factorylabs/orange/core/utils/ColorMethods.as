
package com.factorylabs.orange.core.utils
{
  /**
   * The ColorMethods class is an all-static class with methods for common color conversion needs.
   *
   * <p><strong><em>If performance and file size have super high priority, it is highly recommended to internalize
   * one of these functions into the Class that needs it. Word to your mother.</p></em></strong>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Justin Gitlin
   * @version   1.0.0 :: A very long time ago
   *
   * TODO Convert all use tags to example tags: http://livedocs.adobe.com/flex/3/html/help.html?content=asdoc_6.html – MK.
   */
  final public class ColorMethods
  {
    /**
     * Converts ARGB color values to hex.
     * @param $a    alpha
     * @param $r    red
     * @param $g    green
     * @param $b    blue
     * @return  hex color number
     * @use   {@code var vHex:Number = ColorUtil.argbToHex( 30, 255, 70, 55 );}
     */
    public static function argbToHex( $a :Number, $r :Number, $g :Number, $b :Number ) :Number
    {
        return ( $a << 24 | $r << 16 | $g << 8 | $b );
    }

    /**
     *  Convert a string hex number to the native flash numbers that hex automatically get set to.
     *  @param  $hex  the, uh, hex string.
     *  @return     the flash <code>Number</code> representation of the hex color.
     */
    public static function hexToFlashColorNumber( $hex :String ) :Number
    {
      return Number( $hex );
    }

    /**
     * Converts a hex color number to an object with a, r, g, b properties.
     * @param $hex  the hex color number.
     * @return  an object with r, g, and b color numbers.
     * @use   {@code var vRgb:Number = ColorUtil.hexToARGB( 0x00ffffff );}
     */
    public static function hexToARGB( $hex :Number ) :Object
    {
      var a :Number = ( $hex >> 24 ) & 0xFF;
      var r :Number = ( $hex >> 16 ) & 0xFF;
      var g :Number = ( $hex >> 8 ) & 0xFF;
      var b :Number = ( $hex ) & 0xFF;
        return { a: a, r: r, b: b, g: g };
    }

    /**
     * Converts a hex color number to an object with r, g, b properties.
     * @param $hex  the hex color number.
     * @return  an object with r, g, and b color numbers.
     * @use   {@code var vRgb:Number = ColorUtil.hexToRGB( 0xffffff );}
     */
    public static function hexToRGB( $hex :Number ) :Object
    {
      // bitwise shift the hex numbers.
          var red :Number = $hex >> 16;
          var grnBlu :Number = $hex - ( red << 16 );
          var grn :Number = grnBlu >> 8;
          var blu :Number = grnBlu - ( grn << 8 );

          // return the new object
          return( { r: red, g: grn, b: blu } );
    }

    /**
     *  Convert a native flash number to a string string hex number.
     *  @param  $flashColorNumber   the, native flash color Number.
     *  @return the flash Number representation of the hex color.
     */
    public static function flashColorNumberToHexString( $flashColorNumber :Number ) :String
    {
      return '0x' + $flashColorNumber.toString( 16 );
    }

    /**
     * Converts RGB color values to hex.
     * @param $r    red
     * @param $g    green
     * @param $b    blue
     * @return  hex color number
     * @use   {@code var vHex:Number = ColorUtil.rgbToHex( 255, 70, 55 );}
     */
    public static function rgbToHex( $r :Number, $g :Number, $b :Number ) :Number
    {
          return ( $r << 16 | $g << 8 | $b );
    }
  }
}


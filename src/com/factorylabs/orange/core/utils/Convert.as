
package com.factorylabs.orange.core.utils
{
  /**
   * Makes one thing into another thing all by magic and wizadry.
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
   * @author    Matthew Kitt
   * @version   1.0.0 :: Nov 25, 2009
   */
  final public class Convert
  {
    /**
     * Converts an object to a <code>Boolean</code>.
     * @param $value  The object to be converted.
     * @return  The value as a <code>Boolean</code>.
     * @throws ConversionError
     */
    public static function toBoolean( $value :* ) :Boolean
    {
      if( $value is String )
      {
        if( $value == 'false' )
          return false;
        else if ( $value == 'true' )
          return true;
        else
          throw new ConversionError( 'Invalid format for Boolean: ' + $value );
      }
      else if( $value is int )
      {
        if( $value == 0 )
          return false;
        else if ( $value == 1 )
          return true;
        else
          throw new ConversionError( 'Invalid format for Boolean: ' + $value );
      }
      else
      {
        throw new ConversionError( 'Invalid format for Boolean: ' + $value );
      }
    }

    /**
     * TODO: This is a number formatter.. get this out of here! - MK
     * Converts milliseconds into a nicely-formatted time display
     * @param $milliSeconds the milliseconds to convert
     */
    public static function convertTime( $milliSeconds:Number ) :String
    {
      var secs :Number = Math.floor( $milliSeconds / 1000 );
      var mins :Number = Math.floor( secs / 60 );
      secs %= 60;

      var secsStr :String = String( secs );
      var minsStr :String = String( mins );

      if( secs < 10 ) secsStr = '0' + secs;
      if( mins < 10)  minsStr = '0' + mins;

      // don't return if NaN
      if( minsStr == 'NaN' || secsStr == 'NaN' )
        return( '' );
      else
        return( minsStr + ':' + secsStr );
    }
  }
}

class ConversionError
  extends Error
{
  public function ConversionError( $msg :String )
  {
    super( $msg );
  }
}


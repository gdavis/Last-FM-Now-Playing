
package com.factorylabs.orange.core.math
{
  /**
   * Methods for common math algorithms.
   *
   * <p><strong><em>If performance and file size have super high priority, it is highly recommended to internalize
   * one of these functions into the Class that needs it. Arithmetic is for nerds.</p></em></strong>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Justin Gitlin
   * @version   1.0.0 :: Older than dirt
   *
   * TODO Convert all use tags to example tags: http://livedocs.adobe.com/flex/3/html/help.html?content=asdoc_6.html – MK.
   */
  final public class MathMethods
  {
    /**
     * Convert a number from Degrees to Radians.
     * @param $d  degrees (45°, 90°)
     * v@return radians (3.14..., 1.57...)
     * @use   {@code var vRadians:Number = MathMethods.degreesToRadians( 180 );}
     */
    public static function degreesToRadians( $d :Number ) :Number
    {
      return $d * ( Math.PI / 180 );
    }

    /**
     * Convert a number from Radians to Degrees.
     * @param $r  radians (3.14..., 1.57...)
     * @return  degrees (45°, 90°)
     * @use   {@code var vDegrees:Number = MathMethods.radiansToDegrees( 3.14 );}
     */
    public static function radiansToDegrees( $r :Number ) :Number
    {
      return $r * ( 180 / Math.PI );
    }

    /**
     * Convert a number from a Percentage to Degrees (based on 360°).
     * @param $n  percentage (1, .5)
     * @return  degrees (360°, 180°)
     * @use   {@code var vDegreesPercent:Number = MathMethods.percentToDegrees( 50 );}
     */
    public static function percentToDegrees( $n :Number ) :Number
    {
      return ( ( Math.abs( $n / 100 ) ) * 360 ) * 100;
    }

    /**
     * Convert a number from Degrees to a Percentage (based on 360°).
     * @param $n  degrees (360°, 180°)
     * @return  percentage (1, .5)
     * @use   {@code var vPercentDegrees:Number = MathMethods.degreesToPercent( 180 );}
     */
    public static function degreesToPercent( $n :Number ) :Number
    {
      return ( Math.abs( $n / 360 ) );
    }

    /**
     * Calculates a random number within a minimum and maximum range.
     * @param $min  the value for the bottom range.
     * @param $max  the value for the upper range.
     * @return  the random number within the range.
     * @use   {@code var vRandRange:Number = MathMethods.randRange( 0, 999999 );}
     */
    public static function randRange( $min :Number, $max :Number ) :int
    {
      return Math.round( Math.random() * ( $max - $min ) ) + $min;
    }

    /**
     * Calculates a random number within a minimum and maximum range.
     * @param $min  the value for the bottom range.
     * @param $max  the value for the upper range.
     * @return  the random number within the range.
     * @use   {@code var vRandRange:Number = MathMethods.randRange( 0, 999999 );}
     */
    public static function randRangeDecimel( $min :Number, $max :Number ) :Number
    {
      return Number( Math.random() * ( $max - $min ) + $min );
    }

    /**
     * Rips through an indexed array of numbers adding the total of all values.
     * @param $nums an indexed array of numbers.
     * @return  the sum of all numbers.
     * @use   {@code var vSums:Number = MathMethods.sums( [ 12, 20, 7 ] );}
     *
     * TODO: Use a Vector here.
     */
    public static function sums( $nums :Array ) :Number
    {
      var sum :Number = 0;
      var nums :Array = $nums.slice();
      var i :int = nums.length + 1;
      while( --i != 0 )
      {
        sum += nums.shift();
      }
      return sum;
    }

    /**
     * Report the average of an indexed array of numbers.
     * @param $nums an indexed array of numbers.
     * @return  the average of all numbers.
     * @use   {@code var vAverage:Number = MathMethods.average( [ 12, 20, 7 ] );}
     *
     * TODO: Use a Vector here.
     */
    public static function average( $nums :Array ) :Number
    {
      return sums( $nums ) / $nums.length;
    }

    /**
     * Returns a percentage of a value in between 2 other numbers.
     * @param $bottomRange    low end of the range.
     * @param   $topRange   top end of the range.
     * @param   $valueInRange value to find a range percentage of.
     * @return  The percentage of valueInRange in the range.
     * @use   {@code var vPercent:Number = MathMethods.getPercentWithinRange( 50, 150, 100 );  // displays 50 }
     */
      public static function getPercentWithinRange( $bottomRange :Number, $topRange :Number, $valueInRange :Number ) :Number
    {
      // normalize values to work off zero
      if( $bottomRange < 0 )
      {
        var addToAll :Number = Math.abs( $bottomRange );
        $bottomRange += addToAll;
        $topRange += addToAll;
        $valueInRange += addToAll;
      }
      else if( $bottomRange > 0 )
      {
        var subFromAll :Number = Math.abs( $bottomRange );
        $bottomRange -= subFromAll;
        $topRange -= subFromAll;
        $valueInRange -= subFromAll;
      }
      // simple calc to get percentage
      return 100 * ( $valueInRange / ( $topRange - $bottomRange ) );
    }

    /**
     * Linear interpolate between two values.
     * @param $lower  first value (-1.0, 43.6)
     * @param $upper  second value (-100.0, 3.1415)
       * @param $n  point between values (0.0, 1.0)
     * @return  number (12.3, 44.555)
     * @use   {@code var value:Number = MathMethods.interp( 10, 20, .5 );  //returns 15}
     */
    public static function interp( $lower :Number, $upper :Number, $n :Number ) :Number
    {
      return ( ( $upper - $lower ) * $n ) + $lower;
    }

    /**
     * Re-maps a number from one range to another.
     * @param $value  The incoming value to be converted
     * @param $lower1 Lower bound of the value's current range
     * @param $upper1 Upper bound of the value's current range
     * @param $lower2 Lower bound of the value's target range
     * @param $upper2 Upper bound of the value's target range
     * @return  number (12.3, 44.555)
     * @use   {@code var value:Number = MathMethods.remap( 10, 0, 20, 1, 2 );  //returns 1.5}
     */
    public static function remap( $value :Number, $lower1 :Number, $upper1 :Number, $lower2 :Number, $upper2 :Number ) :Number
    {
      return interp( $lower2, $upper2, getPercentWithinRange( $lower1, $upper1, $value) / 100 );
    }
  }
}


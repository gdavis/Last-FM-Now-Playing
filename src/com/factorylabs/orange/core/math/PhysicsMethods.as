
package com.factorylabs.orange.core.math
{
  /**
   * Methods for common physics algorithms.
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
   * @version   1.0.0 :: ??
   *
   * TODO Convert all use tags to example tags: http://livedocs.adobe.com/flex/3/html/help.html?content=asdoc_6.html – MK.
   */
  final public class PhysicsMethods
  {
    /**
     * Get the angle from coordinate 1 to coordinate 2.
     * @param $x1 the <code>x</code> coordinate of point 1.
     * @param $y1 the <code>y</code> coordinate of point 1.
     * @param $x2 the <code>x</code> coordinate of point 2.
     * @param $y2 the <code>y</code> coordinate of point 2.
     * @return    the angle from one point to another.
     * @use     {@code var vAngle:Number = PhysicsUtil.getAngleToTarget( 10, 20, 50, 70 );}
     */
    public static function getAngleToTarget( $x1 :Number, $y1 :Number, $x2 :Number, $y2 :Number ) :Number
    {
      return -Math.atan2( $x1 - $x2, $y1 - $y2 ) * 180 / Math.PI;
    }

    /**
     * Keep an angle between 0-360.
     * @param   $angle  the angle we want to be sure is between 0 and 360.
     * @return  the constrained angle.
     * @use   {@code var vAngle:Number = PhysicsUtil.constrainAngle( -800 );}
     */
    public static function constrainAngle( $angle :Number ) :Number
    {
      if( $angle < 0 )
        $angle += 360;
      else if( $angle > 360 )
        $angle -= 360;
      return $angle;
    }

    /**
     * Calculates the length of the unknown side of a right triangle, by supplying the 4 points that make up the 2 sides. This is the Pythagorean Theorem.
     * @param $x1     the x1 point coordinate.
     * @param $x2     the x2 point coordinate.
     * @param $y1     the y1 point coordinate.
     * @param $y2     the y2 point coordinate.
     * @return  the length of the unknown side.
     * @use   {@code var vHypotenuse:Number = MathUtil.getHypotenuse( 10, 20, 50, 70 );}
     */
    public static function getHypotenuse( $x1 :Number, $y1 :Number, $x2 :Number, $y2 :Number ) :Number
    {
      return Math.sqrt( ( $x2 - $x1 ) * ( $x2 - $x1 ) + ( $y2 - $y1 ) * ( $y2 - $y1 ) );
    }
  }
}


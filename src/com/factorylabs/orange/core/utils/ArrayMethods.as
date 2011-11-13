
package com.factorylabs.orange.core.utils
{
  import flash.utils.ByteArray;

  /**
   * The ArrayMethods class is an all-static class with methods to extend the capabilities of the <code>Array</code> object.
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
   * @version   1.0.0 :: March 16, 2009
   */
  final public class ArrayMethods
  {
    /**
     * Creates a new unique copy of an array of native flash objects at all indicies.
     *
     * <p>Use with caution. Will cause a runtime error if any objects
     * in arr are not native flash datatypes. The bytearry loses a reference
     * to the class info of custom datatypes.</p>
     *
     * @param $a  the array to clone.
     * @return  a new array that is a complete copy of the one passed in.
     */
    public static function clone( $a :Array ) :Array
    {
      var ba :ByteArray = new ByteArray();
        ba.writeObject( $a );
        ba.position = 0;
        return( ba.readObject() );
    }

    /**
     *  Determines whether the specified array contains the specified value.
     *  @param  $a    the array that will be checked for the specified value.
     *  @param  $value  the object which will be searched for within the array.
     *  @return true if the array contains the value, false if it does not.
     */
    public static function contains( $a :Array, $value :* ) :Boolean
    {
      return ( $a.indexOf( $value ) != -1 );
    }

    /**
     *  Check to make sure the position falls within the bounds of the array.
     *  If its greater than the length reset it to the first index, if its less than 0 reset it to the end index. If its within the bounds just send the index back.
     *  @param  $a  the array upon which to work.
     *  @param  $index  the current index to check.
     *  @return the position within bounds of the array.
     */
    public static function loop( $a :Array, $index :int ) :int
    {
      var len :int = $a.length;
      if( $index < 0 )
        return len - 1;
      else if( $index > len - 1 )
        return 0;
      return $index;
    }

    /**
     *  Retrieve a random element from an <code>Array</code>.
     *  @param  $a  the array to select a random item from.
     *  @return the object at the random index.
     */
    public static function random( $a :Array ) :*
    {
      var len:int = $a.length;
      if ( len > 0 )
        return $a[ Math.floor( Math.random() * len ) ];
      return null;
    }

    /**
     *  Remove all instances of the specified value from the array.
     *  @param  $a    the array from which the value will be removed.
     *  @param  $value  the object that will be removed from the array.
     */
    public static function remove( $a :Array, $value :* ) :void
    {
      var i :int = $a.length;
      while( --i > -1 )
      {
        if( $a[ i ] == $value )
          $a.splice( i, 1 );
      }
    }

    /**
     *  Search and return the index for a specific object in an array.
     *  @param  $a  the array upon which to work.
     *  @param  $search the Object value we are searching for.
     *  @return the index of the element.
     */
    public static function search( $a :Array, $search :* ) :int
    {
      var i :int = $a.length;
      while( --i > -1 )
      {
        if( $a[ i ] == $search )
        {
          return i;
          break;
        }
      }
      return NaN;
    }

    /**
     * Shuffles an existing array.
     * @param $a  the array to shuffle.
     * @param $isUnique true creates a copy of the passed in array, false (default) acts on the original array.
     * @return  the shuffled original or a shuffled copied array.
     */
    public static function shuffle( $a :Array, $isUnique :Boolean = false ) :Array
    {
      if( $isUnique == true )
        $a = $a.slice();
      return $a.sort( function( a :Number, b :Number ) :Number{ a; b; return ( Math.floor( Math.random() * 2 ) == 0) ? 1 : -1; } );
    }
  }
}


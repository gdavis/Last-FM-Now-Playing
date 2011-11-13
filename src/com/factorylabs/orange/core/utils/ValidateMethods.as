
package com.factorylabs.orange.core.utils
{
  /**
   * ValidateMethods for front-end form validation.
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
   * @author    Ryan Boyajian
   * @version   1.0.0 :: ??
   */
  final public class ValidateMethods
  {
    /**
     * Checks to see if a string is a valid email.
     * <p>Original RegExp by Senocular [http://www.senocular.com/]
     * modified to include the "+" in the local-part by RB.</p>
     * @param $email  The string value supposedly formatted as an email.
     * @return  Whether the string is a valid email or not.
     */
    public static function isValidEmail( $email :String ) :Boolean
    {
        var emailExpression :RegExp = /^([a-zA-Z0-9_\.\+\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        return emailExpression.test( $email );
    }

    /**
     * Checks to see if a string is a proper formatted US zip code.
     * <p>12345 and 12345-1234 will return true.</p>
     * @param $zip  The string value used as a US zip code God bless us.
     * @return  Whether the string is a valid US zip code.
     */
    public static function isValidUSZip( $zip :String ) :Boolean
    {
        var zipExpression :RegExp = /(^\d{5}$)|(^\d{5}-\d{4}$)/;
        return zipExpression.test( $zip );
    }

    /**
     * Checks to see if a string is a proper formatted Canadian postal code.
     * <p>A1B2C3 or A1B 2C3 will return true.</p>
     * @param $postal The string value used as a Canadian postal code - Canada gave us hockey everyone!
     * @return  Whether the string is a valid Canadian postal code.
     */
    public static function isValidCanPostal( $postal :String ) :Boolean
    {
        var postalExpression :RegExp = /^[ABCEGHJKLMNPRSTVXY]\d[ABCEGHJKLMNPRSTVWXYZ]\s?\d[ABCEGHJKLMNPRSTVWXYZ]\d$/;
        return postalExpression.test( $postal );
    }

    /**
     * Checks to see if the string is a valid phone number.
     * <p>7777777, 777 7777, or 777-7777 will return true.</p>
     * @param $number The string value to test for a valid US phone number.
     * @return  Whether the string is a valid US phone number.
     * TODO: Needs to support an area code?
     * TODO: should support 303.666.6666 or (303) 666.6666 - (remove all numeric numbers and test if 10 characters)
     */
    public static function isValidPhoneNumber( $number :String ) :Boolean
    {
      var numberExpression :RegExp = /^\d{3}(-|\s)?\d{4}$/;
      return numberExpression.test( $number );
    }

    /**
     * Makes sure the string is a valid area code.
     * <p>123 will return true.</p>
     * @param $areaCode The string to test as a valid US area code.
     * @return  Whether the string is a valid US area code.
     */
    public static function isValidAreaCode( $areaCode :String ) :Boolean
    {
      var areaExpression :RegExp = /^\d{3}$/;
      return areaExpression.test( $areaCode );
    }
  }
}


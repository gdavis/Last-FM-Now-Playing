
package com.factorylabs.orange.core.utils
{
  /**
   * String Utilities class by Ryan Matsikas, Feb 10 2006.
   *
   * <p>Visit www.gskinner.com for documentation, updates and more free code.
   * You may distribute this code freely, as long as this comment block remains intact.</p>
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
   * @author    Ryan Matsikas
   * @version   1.0.0 :: Feb 10 2006
   */
  final public class StringMethods
  {

    /**
     *  Returns everything after the first occurrence of the provided character in the string.
     *
     *  @param p_string The string.
     *
     *  @param p_begin The character or sub-string.
     *
     *  @returns String
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function afterFirst(p_string:String, p_char:String):String
    {
      if (p_string == null) { return ''; }
      var idx:int = p_string.indexOf(p_char);
      if (idx == -1) { return ''; }
      idx += p_char.length;
      return p_string.substr(idx);
    }

    /**
     *  Returns everything after the last occurence of the provided character in p_string.
     *
     *  @param p_string The string.
     *
     *  @param p_char The character or sub-string.
     *
     *  @returns String
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function afterLast(p_string:String, p_char:String):String
    {
      if (p_string == null) { return ''; }
      var idx:int = p_string.lastIndexOf(p_char);
      if (idx == -1) { return ''; }
      idx += p_char.length;
      return p_string.substr(idx);
    }

    /**
     *  Determines whether the specified string begins with the specified prefix.
     *
     *  @param p_string The string that the prefix will be checked against.
     *
     *  @param p_begin The prefix that will be tested against the string.
     *
     *  @returns Boolean
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function beginsWith(p_string:String, p_begin:String):Boolean
    {
      if (p_string == null) { return false; }
      return new RegExp("^"+p_begin,null).test(p_string);
    }

    /**
     *  Returns everything before the first occurrence of the provided character in the string.
     *
     *  @param p_string The string.
     *
     *  @param p_begin The character or sub-string.
     *
     *  @returns String
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function beforeFirst(p_string:String, p_char:String):String
    {
      if (p_string == null) { return ''; }
      var idx:int = p_string.indexOf(p_char);
          if (idx == -1) { return ''; }
          return p_string.substr(0, idx);
    }

    /**
     *  Returns everything before the last occurrence of the provided character in the string.
     *
     *  @param p_string The string.
     *
     *  @param p_begin The character or sub-string.
     *
     *  @returns String
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function beforeLast(p_string:String, p_char:String):String
    {
      if (p_string == null) { return ''; }
      var idx:int = p_string.lastIndexOf(p_char);
          if (idx == -1) { return ''; }
          return p_string.substr(0, idx);
    }

    /**
     *  Returns everything after the first occurance of p_start and before
     *  the first occurrence of p_end in p_string.
     *
     *  @param p_string The string.
     *
     *  @param p_start The character or sub-string to use as the start index.
     *
     *  @param p_end The character or sub-string to use as the end index.
     *
     *  @returns String
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function between(p_string:String, p_start:String, p_end:String):String
    {
      var str:String = '';
      if (p_string == null) { return str; }
      var startIdx:int = p_string.indexOf(p_start);
      if (startIdx != -1) {
        startIdx += p_start.length; // RM: should we support multiple chars? (or ++startIdx);
        var endIdx:int = p_string.indexOf(p_end, startIdx);
        if (endIdx != -1) { str = p_string.substr(startIdx, endIdx-startIdx); }
      }
      return str;
    }

    /**
     *  Capitallizes the first word in a string or all words..
     *
     *  @param p_string The string.
     *
     *  @param p_all (optional) Boolean value indicating if we should
     *  capitalize all words or only the first.
     *
     *  @returns String
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function capitalize(p_string:String, ...args):String
    {
      var str:String = trimLeft(p_string);
      if (args[0] === true) { return str.replace(/^.|\s+(.)/, _upperCase);}
      else { return str.replace(/(^\w)/, _upperCase); }
    }

    /**
     *  Determines whether the specified string contains any instances of p_char.
     *
     *  @param p_string The string.
     *
     *  @param p_char The character or sub-string we are looking for.
     *
     *  @returns Boolean
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function contains(p_string:String, p_char:String):Boolean
    {
      if (p_string == null) { return false; }
      return p_string.indexOf(p_char) != -1;
    }

    /**
     *  Determines the number of times a charactor or sub-string appears within the string.
     *
     *  @param p_string The string.
     *
     *  @param p_char The character or sub-string to count.
     *
     *  @param p_caseSensitive (optional, default is true) A boolean flag to indicate if the
     *  search is case sensitive.
     *
     *  @returns uint
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function countOf(p_string:String, p_char:String, p_caseSensitive:Boolean = true):uint
    {
      if (p_string == null) { return 0; }
      var char:String = escapePattern(p_char);
      var flags:String = (!p_caseSensitive) ? 'ig' : 'g';
      return p_string.match(new RegExp(char, flags)).length;
    }

    /**
     *  Determines whether the specified string ends with the specified suffix.
     *
     *  @param p_string The string that the suffic will be checked against.
     *
     *  @param p_end The suffix that will be tested against the string.
     *
     *  @returns Boolean
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function endsWith(p_string:String, p_end:String):Boolean
    {
      return new RegExp(p_end+"$",null).test(p_string);
    }

    /**
     *  Removes the filename and sends back the extension.
     *  @param  $file File name to extract the extension from.
     *  @return The name of the extension without the file name.
     */
    public static function getExtension( $file :String ) :String
    {
      var extensionIndex :Number = $file.lastIndexOf( '.' );
      if ( extensionIndex == -1 )
        return '';
      else
        return $file.substr( extensionIndex + 1, $file.length );
    }

    /**
     *  Determines whether the specified string contains text.
     *
     *  @param p_string The string to check.
     *
     *  @returns Boolean
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function hasText(p_string:String):Boolean
    {
      var str:String = removeExtraWhitespace(p_string);
      return !!str.length;
    }

    /**
     *  Determines whether the specified string contains any characters.
     *
     *  @param p_string The string to check
     *
     *  @returns Boolean
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function isEmpty(p_string:String):Boolean
    {
      if (p_string == null) { return true; }
      return !p_string.length;
    }

    /**
     *  Determines whether the specified string is numeric.
     *
     *  @param p_string The string.
     *
     *  @returns Boolean
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function isNumeric(p_string:String):Boolean
    {
      if (p_string == null) { return false; }
      var regx:RegExp = /^[-+]?\d*\.?\d+(?:[eE][-+]?\d+)?$/;
      return regx.test(p_string);
    }

    /**
     * Pads p_string with specified character to a specified length from the left.
     *
     *  @param p_string String to pad
     *
     *  @param p_padChar Character for pad.
     *
     *  @param p_length Length to pad to.
     *
     *  @returns String
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function padLeft(p_string:String, p_padChar:String, p_length:uint):String
    {
      var s:String = p_string;
      while (s.length < p_length) { s = p_padChar + s; }
      return s;
    }

    /**
     * Pads p_string with specified character to a specified length from the right.
     *
     *  @param p_string String to pad
     *
     *  @param p_padChar Character for pad.
     *
     *  @param p_length Length to pad to.
     *
     *  @returns String
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function padRight(p_string:String, p_padChar:String, p_length:uint):String
    {
      var s:String = p_string;
      while (s.length < p_length) { s += p_padChar; }
      return s;
    }

    /**
     *  Properly cases' the string in "sentence format".
     *
     *  @param p_string The string to check
     *
     *  @returns String.
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function properCase(p_string:String):String
    {
      if (p_string == null) { return ''; }
      var str:String = p_string.toLowerCase().replace(/\b([^.?;!]+)/, capitalize);
      return str.replace(/\b[i]\b/, "I");
    }

    /**
     *  Escapes all of the characters in a string to create a friendly "quotable" sting
     *
     *  @param p_string The string that will be checked for instances of remove
     *  string
     *
     *  @returns String
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function quote(p_string:String):String
    {
      var regx:RegExp = /[\\"\r\n]/g; //"
      var str:String = '"'+ p_string.replace(regx, _quote) +'"';
      return str; //"
    }

    /**
     *  Removes all instances of the remove string in the input string.
     *
     *  @param p_string The string that will be checked for instances of remove
     *  string
     *
     *  @param p_remove The string that will be removed from the input string.
     *
     *  @param p_caseSensitive An optional boolean indicating if the replace is case sensitive. Default is true.
     *
     *  @returns String
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function remove(p_string:String, p_remove:String, p_caseSensitive:Boolean = true):String
    {
      if (p_string == null) { return ''; }
      var rem:String = escapePattern(p_remove);
      var flags:String = (!p_caseSensitive) ? 'ig' : 'g';
      return p_string.replace(new RegExp(rem, flags), '');
    }

    /**
     *  Removes extraneous whitespace (extra spaces, tabs, line breaks, etc) from the
     *  specified string.
     *
     *  @param p_string The String whose extraneous whitespace will be removed.
     *
     *  @returns String
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function removeExtraWhitespace(p_string:String):String
    {
      if (p_string == null) { return ''; }
      var str:String = trim(p_string);
      return str.replace(/\s+/g, ' ');
    }

    /**
     * Replaces a string with another string via pixie dust.
     * @param $string   The string to act on.
     * @param $replaceThis  The string we are going to vanquish.
     * @param $replaceWith  The string to add in replace of.
     */
    public static function replace( $string :String, $replaceThis :String, $replaceWith :String ) :String
    {
      return $string.split( $replaceThis ).join( $replaceWith );
    }

    /**
     *  Returns the specified string in reverse character order.
     *
     *  @param p_string The String that will be reversed.
     *
     *  @returns String
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function reverse(p_string:String):String
    {
      if (p_string == null) { return ''; }
      return p_string.split('').reverse().join('');
    }

    /**
     *  Returns the specified string in reverse word order.
     *
     *  @param p_string The String that will be reversed.
     *
     *  @returns String
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function reverseWords(p_string:String):String
    {
      if (p_string == null) { return ''; }
      return p_string.split(/\s+/).reverse().join(' ');
    }

    /**
     *  Remove's all < and > based tags from a string
     *
     *  @param p_string The source string.
     *
     *  @returns String
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function stripTags(p_string:String):String
    {
      if (p_string == null) { return ''; }
      return p_string.replace(/<\/?[^>]+>/igm, '');
    }

    /**
     *  Swaps the casing of a string.
     *
     *  @param p_string The source string.
     *
     *  @returns String
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function swapCase(p_string:String):String
    {
      if (p_string == null) { return ''; }
      return p_string.replace(/(\w)/, _swapCase);
    }

    /**
     *  Removes whitespace from the front and the end of the specified
     *  string.
     *
     *  @param p_string The String whose beginning and ending whitespace will
     *  will be removed.
     *
     *  @returns String
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function trim(p_string:String):String
    {
      if (p_string == null) { return ''; }
      return p_string.replace(/^\s+|\s+$/g, '');
    }

    /**
     *  Removes whitespace from the front (left-side) of the specified string.
     *
     *  @param p_string The String whose beginning whitespace will be removed.
     *
     *  @returns String
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function trimLeft(p_string:String):String
    {
      if (p_string == null) { return ''; }
      return p_string.replace(/^\s+/, '');
    }

    /**
     *  Removes whitespace from the end (right-side) of the specified string.
     *
     *  @param p_string The String whose ending whitespace will be removed.
     *
     *  @returns String .
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function trimRight(p_string:String):String
    {
      if (p_string == null) { return ''; }
      return p_string.replace(/\s+$/, '');
    }

    /**
     *  Determins the number of words in a string.
     *
     *  @param p_string The string.
     *
     *  @returns uint
     *
     *  @langversion ActionScript 3.0
     *  @playerversion Flash 9.0
     *  @tiptext
     */
    public static function wordCount(p_string:String):uint
    {
      if (p_string == null) { return 0; }
      return p_string.match(/\b\w+\b/g).length;
    }

    /**
     * Truncates a down based on the maximum number - the length of the suffix and adds the suffix to the string.
     * @param $string The string to evaluate.
     * @param $max    The length to truncate down too (this will be subtracted by the length of $suffix).
     * @param $suffix The string characters to append to the truncated value.
     * @return  The truncated string or original string if truncation is not needed.
     */
    public static function truncate( $string :String, $max :int = -1, $suffix :String = '...' ) :String
    {
      var tmp :String;
      if( $string.length > $max )
      {
        tmp = $string.slice( 0, $max - $suffix.length ) + $suffix;
        return tmp;
      }
      return $string;
    }

    /**
     * Takes a large number and returns a string formatting the number with commas.
     * <p/>
     * For example, the number 10256.434 would return: 10,256 as a string.
     * @param number  The number to format into comma notation.
     */
    public static function formatNumber( number : Number ) : String
    {
      var str : String = number.toString();
      // cut off any decimals.
      if ( str.indexOf( "." ) > -1 ) str = str.substring( 0, str.indexOf( "." ));
      if ( str.length > 3 )
      {
        var arr : Array = [];
        var index : int = str.length % 3;
        if ( index > 0 ) arr.push( str.substring( 0, index ));

        while ( index < str.length )
        {
          arr.push( str.substring( index, index+3 ));
          index += 3;
        }
        str = arr.join( "," );
      }
      return str;
    }

    private static function escapePattern(p_pattern:String):String
    {
      // RM: might expose this one, I've used it a few times already.
      return p_pattern.replace(/(\]|\[|\{|\}|\(|\)|\*|\+|\?|\.|\\)/g, '\\$1');
    }

    private static function _quote(p_string:String, ...args):String
    {
      switch (p_string) {
        case "\\":
          return "\\\\";
        case "\r":
          return "\\r";
        case "\n":
          return "\\n";
        case '"':
          return '\\"';
        default:
          return '';
      }
    }

    private static function _upperCase(p_char:String, ...args):String
    {
      return p_char.toUpperCase();
    }

    private static function _swapCase(p_char:String, ...args):String
    {
      var lowChar:String = p_char.toLowerCase();
      var upChar:String = p_char.toUpperCase();
      switch (p_char) {
        case lowChar:
          return upChar;
        case upChar:
          return lowChar;
        default:
          return p_char;
      }
    }

  }
}



package com.factorylabs.orange.core.net
{
  /**
   * Provides a DTO which stores information on a particular javascript function call..
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Grant Davis
   * @version   1.0.0 :: Feb 17, 2010
   */
  public class JavascriptCall
  {
    /**
     * String value of the javascript function to call.
     */
    public var functionName:String;

    /**
     * Callback method to handle returned javascript data.
     */
    public var callback:Function;

    /**
     * Array of arguments to send to the javascript function.
     */
    public var args:Array;

    /**
     * Indicates the importance of this call. Higher priority values are handled before low priority values.
     */
    public var priority:int;
  }
}


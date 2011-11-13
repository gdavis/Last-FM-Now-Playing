
package com.factorylabs.orange.core.logging
{
  /**
   * LogLevels is a static class for level properties accessed by a logger instance.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Apr 21, 2008
   */
  public class LogLevels
  {
    /**
     * Filter level of <code>Log</code> and custom levels get through.
     */
    public static const LOG   :String = 'LOG';

    /**
     * Filter level of <code>Debug</code>, <code>Log</code> and custom levels get through.
     */
    public static const DEBUG :String = 'DEBUG';

    /**
     * Filter level of <code>Info</code>, <code>Debug</code>, <code>Log</code> and custom levels get through.
     */
    public static const INFO  :String = 'INFO';

    /**
     * Filter level of <code>Warn</code>, <code>Info</code>, <code>Debug</code>, <code>Log</code> and custom levels get through.
     */
    public static const WARN  :String = 'WARN';

    /**
     * Filter level of <code>Error</code>, <code>Warn</code>, <code>Info</code>, <code>Debug</code>, <code>Log</code> and custom levels get through.
     */
    public static const ERROR :String = 'ERROR';

    /**
     * Filter level of <code>Fatal</code>, <code>Error</code>, <code>Warn</code>, <code>Info</code>, <code>Debug</code>, <code>Log</code> and custom levels get through.
     */
    public static const FATAL :String = 'FATAL';

    /**
     * Filter level of <code>Core</code>, <code>Fatal</code>, <code>Error</code>, <code>Warn</code>, <code>Info</code>, <code>Debug</code>, <code>Log</code> and custom levels get through.
     */
    public static const CORE  :String = 'CORE';

    /**
     * Special Filter for popping JavaScript Alerts. Always comes through.
     *
     * @example The following code pops a JavaScript Alert window.
     * <listing version="3.0" >
     * _logger.trace( "[AbstractView].initialize()", _data, LogLevels.JSALERT );
     * </listing>
     */
    public static const JSALERT :String = 'JSALERT';

    /**
     * Empty constructor for a class containing only static constants
     */
    public function LogLevels(){}

    /**
     * @return  The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.logger.LogLevels';
    }
  }
}


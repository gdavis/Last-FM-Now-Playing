
package com.factorylabs.orange.core.logging
{
  import org.osflash.signals.Signal;

  /**
   * Basic necessities for capturing incoming messages and objects categorized by levels and a logger's indentifier.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Feb 16, 2009
   */
  public interface ILogger
  {
    /**
     * The name of the logger dispatching signals.
     */
    function get name() :String;
    function set name( $name :String ) :void;

    /**
     * Whether this logger is suppressing it's signals.
     */
    function get isSilent() :Boolean;
    function set isSilent( $isSilent :Boolean ) :void;

    /**
     * The <code>Signal</code> object used for sending log details.
     */
    function get signal() :Signal;
    function set signal( $signal :Signal ) :void;

    /**
     * @return The string equivalent of this class
     */
    function toString() :String;

    /**
     * Handles the basic necessities of logging a message, all class methods are filtered through here.
     * Precondition:  An optional message, optional object and optional level
     * Postcondition: A dispatched log signal if there are listeners and the logger isn't silenced.
     * @param $msg    <code>String</code> message to trace out.
     * @param $object <code>Object</code> to be inspected via the debugger.
     * @param $level  <code>LogLevels</code> constant or custom notification filter.
     *
     * @example The following code logs a command with a custom level.
     * <listing version="3.0" >
     * var logger :Logger = new Logger();
     * logger.trace( "[AbstractView].initialize()", _data, "MK" );
     * </listing>
     */
    function trace( $msg :String = '', $object :Object = null, $level :String = null ) :void;

    /**
     * Logs the message and object through trace with the <code>LogLevels.LOG</code> filter.
     * @param $msg    <code>String</code> message to trace out.
     * @param $object <code>Object</code> to be inspected via the debugger.
     *
     * @example The following code logs a command with a level of LOG.
     * <listing version="3.0" >
     * var logger :Logger = new Logger();
     * logger.level = LogLevels.LOG;
     * logger.log( "[AbstractView].initialize()", _data );
     * </listing>
     */
    function log( $msg :String = '', $object :Object = null ) :void;

    /**
     * Logs the message and object through trace with the <code>LogLevels.DEBUG</code> filter.
     * @param $msg    <code>String</code> message to trace out.
     * @param $object <code>Object</code> to be inspected via the debugger.
     *
     * @example The following code logs a command with a level of DEBUG.
     * <listing version="3.0" >
     * var logger :Logger = new Logger();
     * logger.level = LogLevels.DEBUG;
     * logger.debug( "[AbstractView].initialize()", _data );
     * </listing>
     */
    function debug( $msg :String = '', $object :Object = null ) :void;

    /**
     * Logs the message and object through trace with the <code>LogLevels.INFO</code> filter.
     * @param $msg    <code>String</code> message to trace out.
     * @param $object <code>Object</code> to be inspected via the debugger.
     *
     * @example The following code logs a command with a level of INFO.
     * <listing version="3.0" >
     * var logger :Logger = new Logger();
     * logger.level = LogLevels.INFO;
     * logger.info( "[AbstractView].initialize()", _data );
     * </listing>
     */
    function info( $msg :String = '', $object :Object = null ) :void;

    /**
     * Logs the message and object through trace with the <code>LogLevels.WARN</code> filter.
     * @param $msg    <code>String</code> message to trace out.
     * @param $object <code>Object</code> to be inspected via the debugger.
     *
     * @example The following code logs a command with a level of WARN.
     * <listing version="3.0" >
     * var logger :Logger = new Logger();
     * logger.level = LogLevels.WARN;
     * logger.warn( "[AbstractView].initialize()", _data );
     * </listing>
     */
    function warn( $msg :String = '', $object :Object = null ) :void;

    /**
     * Logs the message and object through trace with the <code>LogLevels.ERROR</code> filter.
     * @param $msg    <code>String</code> message to trace out.
     * @param $object <code>Object</code> to be inspected via the debugger.
     *
     * @example The following code logs a command with a level of ERROR.
     * <listing version="3.0" >
     * var logger :Logger = new Logger();
     * logger.level = LogLevels.ERROR;
     * logger.error( "[AbstractView].initialize()", _data );
     * </listing>
     */
    function error( $msg :String = '', $object :Object = null ) :void;

    /**
     * Logs the message and object through trace with the <code>LogLevels.FATAL</code> filter.
     * @param $msg    <code>String</code> message to trace out.
     * @param $object <code>Object</code> to be inspected via the debugger.
     *
     * @example The following code logs a command with a level of FATAL.
     * <listing version="3.0" >
     * var logger :Logger = new Logger();
     * logger.level = LogLevels.FATAL;
     * logger.fatal( "[AbstractView].initialize()", _data );
     * </listing>
     */
    function fatal( $msg :String = '', $object :Object = null ) :void;

    /**
     * Logs the message and object through trace with the <code>LogLevels.CORE</code> filter.
     * @param $msg    <code>String</code> message to trace out.
     * @param $object <code>Object</code> to be inspected via the debugger.
     *
     * @example The following code logs a command with a level of CORE.
     * <listing version="3.0" >
     * var logger :Logger = new Logger();
     * logger.level = LogLevels.CORE;
     * logger.core( "[AbstractView].initialize()", _data );
     * </listing>
     */
    function core( $msg :String = '', $object :Object = null ) :void;
  }
}


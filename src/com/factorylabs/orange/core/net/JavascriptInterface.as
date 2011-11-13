
package com.factorylabs.orange.core.net
{
  import flash.events.TimerEvent;
  import flash.external.ExternalInterface;
  import flash.utils.Timer;
  import flash.utils.getTimer;

  /**
   * Provides a javascript interface which queues calls with priorities.
   *
   * <p>JavascriptInterface is used to eliminate issues when issuing multiple calls in quick succession,
   * which can potentially silently fail if executed too quickly via ExternalInterface. JavascriptInterface
   * utilizes a queueing system with priorities in order to ensure no javascript calls are lost.</p>
   *
   * <p>Below is an example of Actionscript what will call a Javascript method named <code>test</code>
   * and get the returned results in a handler function.
   *
   * <p><b>Javascript:</b></p>
   * <listing>
   * function test( arg1, arg2, arg3 )
   * {
   *    return [ arg1, arg2, arg3 ];
   * }</listing>
   *
   * <p><b>Actionscript:</b></p>
   * <listing>
   * JavascriptInterface.call( "test", handleCallback, "one", "two", 3 );
   *
   * private function handleCallback( value ):void
   * {
   *    // value returns native array type: "one", "two", 3
   * }</listing>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    grantdavis
   * @version   1.0.0 :: Feb 17, 2010
   */
  public class JavascriptInterface
  {
    /**
     * Number of miliseconds between each Javascript call.
     */
    private static const JS_CALL_DELAY:int = 250;

    /**
     * Array to queue javascript calls.
     */
    private static var _jsCalls:Array = [];

    /**
     * Timer instance.
     */
    private static var _jsTimer:Timer;

    /**
     * Tracks the last time a call was made. We track this to make sure no more than 1 call goes
     * out within the <code>JS_CALL_DELAY</code> timeframe.
     */
    private static var _lastCallTime:int;

    /**
     * Adds a javascript call to the queue.
     *
     * <p>This method serves as an alternative to directly using External Interface. There are a couple advantages
     * of using JavascriptInterace over a direct ExternalInterface call. Some browsers will ignore javascript calls
     * from the Flash Player if they are executed too quickly, and JavascriptInterface delays each call to prevent this.</p>
     *
     * <p>Secondly, it allows each call to have a priority which will make some calls execute before others in the queue.
     * Specifying a higher priority force the call to execute before other calls.</p>
     *
     * @param functionName  Javascript function to call.
     * @param priority    [Optional] Defines the level of priority for the call. Higher priority calls will occur before lower priority calls.
     * @param callback    [Optional] Function to handle any returned values from the javascript function.
     * @param arguments   [Optional] A list of arguments to pass to javascript function.
     */
    public static function call( functionName:String, priority:int=0, callback:Function=null, ...arguments ):void
    {
      // don't make any calls if we don't have javascript access.
      if ( !ExternalInterface.available ) return;

      var currentTime:int = getTimer();

      // make sure timer is built.
      if ( _jsTimer == null ) buildTimer();

      // create and populate the javascript call object.
      var jsCall:JavascriptCall = new JavascriptCall();
      jsCall.functionName = functionName;
      jsCall.callback = callback;
      jsCall.args = arguments;
      jsCall.priority = priority;

      // store javascript call.
      _jsCalls.push( jsCall );
      // sort array on priority.
      _jsCalls.sort( sortByPriority );

      // if there weren't any previously queued items,
      // go ahead and make the call right away.
      if ( _jsCalls.length == 1 && currentTime - _lastCallTime > JS_CALL_DELAY )
      {
        nextCall();
      }
      // start the queue.
      else startQueue();

      // record the time this call was fired.
      _lastCallTime = currentTime;
    }

    /**
     * Opens up a pop-up window through Javascript. If it fails the specified alert message will appear in the browser window.
     *
     * @param url     The URL of the pop-up html.
     * @param windowName  The window name of the pop-up.
     * @param options   The options for the window.
     * @param alertMessage  [Optional] The message to display if a pop-up was not able to successfully open.
     */
    public static function openPopup( url:String, windowName:String, options:String, alertMessage:String = 'A pop-up from this site was unable to open. Please disable your pop-up blocker.' ) : void
    {
      var openPopupWindow:XML =
      <script>
        <![CDATA[
          function( url, windowName, options, alertMessage )
          {
            var popupWindow = window.open( url, windowName, options );
            if( !popupWindow ) setTimeout( alert, 1000, new Array( alertMessage ) );
          }
        ]]>
      </script>;
      call( openPopupWindow, 0, null, url, windowName, options, alertMessage );
    }


    /**
     * Builds the timer object that will run an infinite number of times.
     */
    private static function buildTimer():void
    {
      // create the timer object for sending calls.
      _jsTimer = new Timer( JS_CALL_DELAY, 0 );
      _jsTimer.addEventListener( TimerEvent.TIMER, onTick );
    }

    /**
     * Handles each tick of the timer and issues an ExternalInterface call from the queue.
     * @param evt   Event from the dispatching Timer object.
     */
    private static function onTick( evt:TimerEvent ):void
    {
      nextCall();
    }

    /**
     * Builds and starts the call timer if not already built and running.
     */
    private static function startQueue():void
    {
      // start timer if its not running.
      if ( !_jsTimer.running )
        _jsTimer.start();
    }

    /**
     * Checks the remaining items in queue. If there are no more items,
     * the Timer triggering call events will be stopped.
     */
    private static function checkQueue():void
    {
      // stop the timer if we're out of calls.
      if ( _jsCalls.length <= 0 )
      {
        _jsTimer.stop();
      }
    }

    /**
     * Performs the next javscript call in sequence.
     */
    private static function nextCall():void
    {
      // pull first item from the queue.
      var jsCall:JavascriptCall = _jsCalls.shift();

      // create an arguments array to apply on the ExternalInterface.call method.
      var args:Array = [ jsCall.functionName ];

      // run the call() method and apply our arguments on it. store any returned value from the call.
      var returnedValue:* = ExternalInterface.call.apply( ExternalInterface, args.concat( jsCall.args ));

      // send returned value to the callback function
      if ( jsCall.callback != null )
        jsCall.callback.apply( jsCall.callback, [ returnedValue ]);

      // check if there are remaining items in queue.
      checkQueue();
    }

    /**
     * Utility method to sort the internal calls based on priority levels from highest to lowest.
     */
    private static function sortByPriority( a:JavascriptCall, b:JavascriptCall ):int
    {
      if ( a.priority > b.priority ) return -1;
      else if ( a.priority == b.priority ) return 0;
      else return 1;
    }

  }
}


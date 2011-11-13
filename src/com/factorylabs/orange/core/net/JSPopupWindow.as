
package com.factorylabs.orange.core.net
{
  import flash.utils.describeType;

  /**
   * Generates the string of arguments to be passed to JavaScript for window.open().
   *
   * <p>For further information about <code>window.open()</code> parameters see: <a target="_top" href="http://www.w3schools.com/jsref/met_win_open.asp">The W3 Schools documentation</a></p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Grant Davis
   * @version   1.0.0 :: May 20, 2008
   *
   * @author    Matthew Kitt
   * @version   2.0.0 :: Feb 12, 2010 :: Refactored to utilize reflection.
   *
   * TODO: I feel like this isn't the right name for this class, it's just concatenating name/value pairs and not
   * actually popping a window. Anyone have some thoughts on this? - MK.
   */
  public class JSPopupWindow
  {
    public var url        :String;
    public var windowName   :String;
    public var width      :String;
    public var height     :String;
    public var innerWidth   :String;
    public var innerHeight    :String;
    public var outerHeight    :String;
    public var screenX      :String;
    public var screenY      :String;
    public var resizable    :String;
    public var location     :String;
    public var status     :String;
    public var menubar      :String;
    public var personalbar    :String;
    public var titlebar     :String;
    public var toolbar      :String;
    public var scrollbars   :String;
    public var hotkeys      :String;
    public var directories    :String;
    public var alwaysRaised   :String;
    public var alwaysLowered  :String;
    public var dependent    :String;

    /**
     * Initializes the required arguments for spawning a js popup window.
     * <p>For further information about <code>window.open()</code> parameters see: <a target="_top" href="http://www.w3schools.com/jsref/met_win_open.asp">The W3 Schools documentation</a></p>
     */
    public function JSPopupWindow(  $url :String,
                    $windowName :String,
                    $width  :String = '400',
                    $height :String = '300',
                    $resizable :String = 'yes',
                    $location :String = 'yes',
                    $scrollbars :String = 'yes',
                    $menubar :String = 'yes',
                    $titlebar :String = 'yes',
                    $personalbar :String = 'yes',
                    $toolbar :String = 'yes' )
    {
      url = $url;
      windowName = $windowName;
      width = $width;
      height = $height;
      resizable = $resizable;
      location = $location;
      scrollbars = $scrollbars;
      menubar = $menubar;
      titlebar = $titlebar;
      personalbar = $personalbar;
      toolbar = $toolbar;
    }

    /**
     * @return The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.net.JSPopupWindow';
    }

    /**
     * Public access for concatenating js arguments.
     * @return  A nice little string.
     */
    public function getWindowArguments() :String
    {
      return concatenate();
    }

    /**
     * Introspects itself and concatenates public variables into a js argument string, ignoring any null values.
     * @return  A nice little string.
     */
    protected function concatenate() :String
    {
      var args :String = '';
      var desc :XML = describeType( this );
      var vars :XMLList = desc.descendants( 'variable' );
      var len :int = vars.length();

      for( var i :int = 0; i < len; ++i )
      {
        var name :String = vars[ i ].@name;
        var value :String = this[vars[ i ].@name];

        if( value )
        {
          args += name + '=' + value;
          args += ( i != len - 1 ) ? ',' : '';
        }
      }
      return args;
    }
  }
}



package com.factorylabs.orange.core.display.stage
{
  import com.factorylabs.orange.core.IDisposable;
  import com.factorylabs.orange.core.signals.StageSignal;

  import flash.display.DisplayObject;
  import flash.display.Stage;
  import flash.display.StageAlign;

  /**
   * Aligns a display object container to a stated position of the stage.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   *  @author     Matthew Kitt, Grant Davis
   *  @version    1.0.0 :: 10.31.2007
   */
  public class StageAlignment
    implements IDisposable
  {
    /**
     * @private
     */
    protected var _container    :DisplayObject;

    /**
     * @private
     */
    protected var _stage      :Stage;

    /**
     * @private
     */
    protected var _signal       :StageSignal;

    /**
     * @private
     */
    protected var _containerWidth   :Number;

    /**
     * @private
     */
    protected var _containerHeight  :Number;

    /**
     * @private
     */
    protected var _position     :String;

    /**
     * @private
     */
    protected var _padding      :Array;

    /**
     * Return the container being used for aligning to the <code>Stage</code>.
     */
    public function get container() :DisplayObject { return _container; }

    /**
     * Return the container's width property, either manually set or set by it's actual width.
     */
    public function get containerWidth() :Number { return _containerWidth; }

    /**
     * Return the container's height property, either manually set or set by it's actual height.
     */
    public function get containerHeight() :Number { return _containerHeight; }

    /**
     * Return the alignment property generally from <code>StageAlign</code> property except for the string <code>'CENTER'</code>.
     */
    public function get position() :String { return _position; }

    /**
     * Return the <code>Array</code> of padding values, same as CSS [top, right, bottom, left].
     * <p>Note: on anything that is centered only the top or left padding will be applied.</p>
     */
    public function get padding() :Array { return _padding; }

    /**
     * Initializes properties and initial state of a StageAlignment object.
     * @param $container    The container to align to the <code>Stage.Align</code> property – use "CENTER" for absolute middle.
     * @param $stageSignal    The <code>StageSignal</code> object dispatching resize events (signal).
     * @param $containerWidth The <code>width</code> of the container or an absolute value.
     * @param $containerHeight  The <code>height</code> of the container or an absolute value.
     * @param $position     The <code>StageAlign</code> property for the container's position on the stage, if absolute middle use <code>'CENTER'</code>.
     * @param $padding      Padding values to apply to the positioning, (same as CSS [top, right, bottom, left]), anything that is centered only the top or left padding will be applied.
     */
    public function StageAlignment( $container :DisplayObject,
                    $stageSignal :StageSignal,
                    $containerWidth :Number = NaN,
                    $containerHeight: Number = NaN,
                    $position :String = StageAlign.TOP_LEFT,
                    $padding :Array = null )
    {
      _container = $container;
      _stage = _container.stage;
      _signal = $stageSignal;
      _containerWidth = ( isNaN( $containerWidth) ) ? _container.width : $containerWidth;
      _containerHeight = ( isNaN( $containerHeight) ) ? _container.height : $containerHeight;
      _position = $position;
      _padding = $padding || [0,0,0,0];
      checkPaddingLength();
      init();
    }

    /**
     * @return The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.display.stage.StageAlignment';
    }

    /**
     * Sets the size of the container's values, <code>onResize</code> will be called.
     * @param $containerWidth An absolute width value, if <code>NaN</code>, the container's <code>width<code> will be used.
     * @param $containerHeight  An absolute height value, if <code>NaN</code>, the container's <code>height<code> will be used.
     */
    public function setSize( $containerWidth :Number = NaN, $containerHeight :Number = NaN ) :void
    {
      _containerWidth = ( isNaN( $containerWidth) ) ? _container.width : $containerWidth;
      _containerHeight = ( isNaN( $containerHeight) ) ? _container.height : $containerHeight;
      onResize();
    }

    /**
     * Sets the position type to use for aligning the container, <code>onResize</code> will be called.
     * @param $position Generally from <code>StageAlign</code> property except for the string <code>'CENTER'</code>.
     */
    public function setPosition( $position :String ) :void
    {
      _position = $position;
      onResize();
    }

    /**
     * Set the <code>Array</code> of padding values, same as CSS [top, right, bottom, left].
     * <p>Note: on anything that is centered only the top or left padding will be applied.</p>
     * @param $padding  The <code>Array</code> with a length of 4 values.
     */
    public function setPadding( $padding :Array ) :void
    {
      _padding = $padding;
      checkPaddingLength();
      onResize();
    }

    /**
     * Captures <code>Signal</code> dispatches when the stage is resized.
     */
    public function onResize() :void
    {
      calculate();
    }

    /**
     * Moves the container to new <code>x</code> and <code>y</code> values.
     * @param $x  The <code>x</code> position.
     * @param $y  The <code>y</code> position.
     */
    public function move( $x :Number, $y :Number ) :void
    {
      _container.x = $x;
      _container.y = $y;
    }

    /**
     * @inheritDoc
     */
    public function dispose() :void
    {
      _signal.remove( onResize );
    }

    /**
     * Called from instantiation, adds the <code>onResize</code> callback to the signal and forces a resize.
     */
    protected function init() :void
    {
      _signal.add( onResize );
      onResize();
    }

    /**
     * Ensures the <code>padding</code> array has a length of 4 values.
     * @throws  ArgumentError <code>ArgumentError</code> When an invalid length was passed in.
     */
    protected function checkPaddingLength() :void
    {
      if( _padding.length != 4 )
        throw new ArgumentError( 'Padding must have a length of 4 values for top, right, bottom, left.' );
    }

    /**
     * Calculates <code>x</code> and <code>y</code> values based on position, padding and size.
     */
    protected function calculate() :void
    {
      var x :Number = 0;
      var y :Number = 0;
      var align :String = _position;

      switch ( align )
      {
        case 'TOP' :
        case 'T' :
          x = alignHorizontalCenter();
          y = alignVerticalTop();
        break;

        case 'TOP_LEFT' :
        case 'TL' :
          x = alignHorizontalLeft();
          y = alignVerticalTop();
        break;

        case 'CENTER' :
        case 'C' :
          x = alignHorizontalCenter();
          y = alignVerticalCenter();
        break;

        case 'BOTTOM' :
        case 'B' :
          x = alignHorizontalCenter();
          y = alignVerticalBottom();
        break;

        case 'LEFT' :
        case 'L' :
          x = alignHorizontalLeft();
          y = alignVerticalCenter();
        break;

        case 'RIGHT' :
        case 'R' :
          x = alignHorizontalRight();
          y = alignVerticalCenter();
        break;

        case 'TOP_RIGHT' :
        case 'TR' :
          x = alignHorizontalRight();
          y = alignVerticalTop();
        break;

        case 'BOTTOM_LEFT' :
        case 'BL' :
          x = alignHorizontalLeft();
          y = alignVerticalBottom();
        break;

        case 'BOTTOM_RIGHT' :
        case 'BR' :
          x = alignHorizontalRight();
          y = alignVerticalBottom();
        break;

        default :
          x = alignHorizontalCenter();
          y = alignVerticalTop();
        break;
      }
      move( x, y );
    }

    /**
     * Aligns the container's <code>x</code> position to the absolute middle of the stage.
     */
    protected function alignHorizontalCenter() :Number
    {
      var cenX :Number = ( _stage.stageWidth * .5 ) - ( _containerWidth * .5 ) + _stage.x;
      return Number( cenX + _padding[ 3 ] );
    }

    /**
     * Aligns the container's <code>x</code> position to the left edge of the stage.
     */
    protected function alignHorizontalLeft():Number
    {
      return Number( _padding[ 3 ] + _stage.x );
    }

    /**
     * Aligns the container's <code>x</code> position to the right edge of the stage.
     */
    protected function alignHorizontalRight() :Number
    {
      return Number( ( _stage.stageWidth - _containerWidth ) - _padding[ 1 ] + _stage.x );
    }

    /**
     * Aligns the container's <code>y</code> position to the absolute middle of the stage.
     */
    protected function alignVerticalCenter() :Number
    {
      var cenY:Number = ( _stage.stageHeight * .5 ) - ( _containerHeight * .5 ) + _stage.y;
      return Number( cenY + _padding[ 0 ] );
    }

    /**
     * Aligns the container's <code>y</code> position to the top edge of the stage.
     */
    protected function alignVerticalTop() :Number
    {
      return _padding[ 0 ] + _stage.y;
    }

    /**
     * Aligns the container's <code>y</code> position to the bottom edge of the stage.
     */
    protected function alignVerticalBottom() :Number
    {
      return Number(( _stage.stageHeight - _containerHeight ) - _padding[ 2 ] + _stage.y );
    }
  }
}


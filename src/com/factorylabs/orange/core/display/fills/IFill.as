
package com.factorylabs.orange.core.display.fills
{
  import flash.display.Graphics;
  import com.factorylabs.orange.core.display.graphics.IGraphic;

  /**
   * IFill is an interface for <code>IGraphic</code> shapes with either a fill or a stroke.
   *
   * <p>We've run performance tests against the native <code>GraphicsSolidFill</code> through the <code>drawGraphicsData</code> and this runs about 96% faster.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @see com.factorylabs.orange.core.display.graphics.IGraphic
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Jun 1, 2008
   */
  public interface IFill
  {
    /**
     * Fills or strokes a subclass of <code>Graphic</code>, generally called only internally by an instance of <code>IGraphic</code>.
     * @param $gfx  reference to the <code>shape.graphics</code>.
     * @param $igfx reference to the @see com.factorylabs.orange.core.display.graphics.IGraphic only used for Bitmap fills and Gradient stroke/fills.
     */
    function begin( $gfx :Graphics, $igfx :IGraphic ) :void;

    /**
     * Closes a fill or stroke on a <code>Graphic</code>, generally called only internally by an instance of <code>IGraphic</code>.
     * @param $gfx  reference to the <code>shape.graphics</code>.
     */
    function end( $gfx :Graphics ) :void;
  }
}



package com.factorylabs.orange.core.printing
{
  import flash.geom.Rectangle;
  import flash.display.Sprite;
  import flash.printing.PrintJob;
  import flash.printing.PrintJobOptions;

  /**
   * Handles printing to a User's printer.
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Ryan Boyajian
   * @version   1.0.0 :: Apr 18, 2008
   * @version   1.5.0 :: Feb 6, 2010 :: Ported from a static class, changes some names and refactored a touch. -MK
   */
  public class Print
  {
    /**
     * @private
     */
    protected var _printJob     :PrintJob;

    /**
     * @private
     */
    protected var _printJobOptions  :PrintJobOptions;

    /**
     * @private
     */
    protected var _sprite     :Sprite;

    /**
     * Instantiate a <code>Print</code> object to be used for printing.
     * @param $sprite     The <code>Sprite</code> to be printed.
     * @param $printAsBitmap  Boolean for printing as a bitmap.
     *              Vector printing will sometimes produce a smaller spool file, and a better image
     *              than bitmap printing. However, if your content includes a bitmap image, and you
     *              want to preserve any alpha transparency or color effects, you should print the
     *              page as a bitmap image.
     */
    public function Print( $sprite :Sprite, $printAsBitmap :Boolean = false )
    {
      _printJob = new PrintJob();
      _printJobOptions = new PrintJobOptions( $printAsBitmap );
      _sprite = $sprite;
    }

    /**
     * @return  The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.printing.Print';
    }

    /**
     * Prints a <code>Sprite</code> to a page(s).
     * @param $scale      Boolean for scaling the sprite down to page width.
     * @param $pageCutoffBuffer The number of pixels to overlap at the bottom of multi page prints so that nothing
     *              is completely cut off or in half.
     *  @return Whether the print job was sent or cancelled.
     */
    public function start( $scale :Boolean = false, $pageCutoffBuffer :int = 15 ) :Boolean
    {
      if( $scale )
        scaleToFit();

      if( _printJob.start() )
        return sendJob( stackPages( $pageCutoffBuffer ) );
      else
        return false;
    }

    /**
     * Send the print job off to the printer.
     * @param $pages  $pages number of pages to be printed.
     * @return  Whether the print job was sent or cancelled.
     */
    protected function sendJob( $pages :int ) :Boolean
    {
      if( $pages > 0 )
      {
        _printJob.send();
        return true;
      }
      else
        return false;
    }

    /**
     * Stack a queue of pages to be printed.
     * @param $pageCutoffBuffer The number of pixels to overlap at the bottom of multi page prints so that nothing
     *              is completely cut off or in half.
     * @return  The number of pages to print.
     */
    protected function stackPages( $pageCutoffBuffer :int ) :int
    {
      var printPages :int = 0;
      if( _sprite.height > _printJob.pageHeight )
        printPages = multiplePages( $pageCutoffBuffer );
      else
        printPages += addPage();
      return printPages;
    }

    /**
     * Adds multiple pages to the stack for printing.
     * @param $pageCutoffBuffer The number of pixels to overlap at the bottom of multi page prints so that nothing
     *              is completely cut off or in half.
     * @return  The number of pages to print.
     */
    protected function multiplePages( $pageCutoffBuffer :int ) :int
    {
      var pjh :int = _printJob.pageHeight;
      var numPages :Number = Math.ceil( _sprite.height / pjh );
      var updatedHeight :Number = _sprite.height + ( $pageCutoffBuffer * numPages );
      numPages = Math.ceil( updatedHeight / pjh );

      var pages :int = 0;
      var rect :Rectangle = new Rectangle( 0, 0, _printJob.pageWidth, pjh );

      for( var i :int = 0; i < numPages; i++ )
      {
        pages += addPage( rect );
        rect.y += pjh - $pageCutoffBuffer;
      }
      return pages;
    }

    /**
     * Adds a single page to the queue to print.
     * @param $rectangle  An optional Rectangle to use for cutting off a page.
     * @return  The incremental page count.
     */
    protected function addPage( $rectangle :Rectangle = null ) :int
    {
      var added :int = 0;
      try
      {
        _printJob.addPage( _sprite, $rectangle, _printJobOptions );
        added = 1;
      }
      catch( $e :Error) {}
      return added;
    }

    /**
     * Scales the sprite proportionally down to fit the page setup type.
     */
    protected function scaleToFit() :void
    {
      var pw :int = _printJob.pageWidth;

      while( _sprite.width > pw )
      {
        _sprite.scaleX -= 1;
        _sprite.scaleY -= 1;
      }
    }
  }
}


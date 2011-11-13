
package com.factorylabs.orange.core.text
{
  import flash.text.TextFormat;
  import com.factorylabs.orange.core.collections.Map;

  import flash.text.StyleSheet;

  /**
   * It's like a closet, only with style objects in it.
   *
   * <p>Manages the storage and retrieval for the applications style objects through a <code>Map</code>
   * <code>StyleSheets</code>, <code>TextFormat</code> and generic objects (fills, shapes) should be stored here.</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Feb 8, 2010
   */
  public class FStyleManager
  {
    /**
     * @private
     */
    protected var _map :Map;

    /**
     * Instantiates the object and an internal map for storage.
     */
    public function FStyleManager()
    {
      _map = new Map( true );
    }

    /**
     * @return The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.text.FStyleManager';
    }

    /**
     * Returns the number of style objects within the <code>Map</code>.
     */
    public function get length() :uint
    {
      return _map.length;
    }

    /**
     * Returns the key identifiers stored within the <code>Map</code>.
     */
    public function get keys() :Array
    {
      return _map.keys;
    }

    /**
     * Add a <code>StyleSheet</code> to the <code>Map</code>.
     * @param $key  The string identifier associated with the style sheet.
     * @param $css  The stylesheet to be referenced by the key.
     */
    public function addStyleSheet( $key :String, $css :StyleSheet ) :void
    {
      _map.add( $key, $css );
    }

    /**
     * Add a <code>StyleSheet</code> to the <code>Map</code> from <code>XML</code>.
     * @param $key  The string identifier associated with the style sheet.
     * @param $xml  The xml value to be converted into a <code>StyleSheet</code> before being added to the <code>Map</code>.
     * @return  The converted <code>XML</code> as a <code>StyleSheet</code>.
     */
    public function addStyleSheetFromXML( $key :String, $xml :XML ) :StyleSheet
    {
      var css :StyleSheet = parseXMLToCSS( $xml );
      addStyleSheet( $key, css );
      return css;
    }

    /**
     * Add a <code>StyleSheet</code> to the <code>Map</code> from a <code>String</code>.
     * @param $key  The string identifier associated with the style sheet.
     * @param $str  The string to be converted into a <code>StyleSheet</code> before being added to the <code>Map</code>.
     * @return  The converted <code>String</code> as a <code>StyleSheet</code>.
     */
    public function addStyleSheetFromString( $key :String, $str :String ) :StyleSheet
    {
      var css :StyleSheet = parseStringToCSS( $str );
      addStyleSheet( $key, css );
      return css;
    }

    /**
     * Adds a <code>TextFormat</code> object to the <code>Map</code>.
     * @param $key    The string identifier associated with the text format object.
     * @param $format The textformat to be referenced by the key.
     */
    public function addTextFormat( $key :String, $format :TextFormat ) :void
    {
      _map.add( $key, $format );
    }

    /**
     * Adds a generic object (<code>SolidFill</code>, <code>FRectangle</code>)to the <code>Map</code>.
     * @param $key    The string identifier associated with the generic object.
     * @param $style  The generic object to be referenced by the key.
     */
    public function addGenericStyle( $key :String, $style :* ) :void
    {
      _map.add( $key, $style );
    }

    /**
     * Returns a <code>StyleSheet</code> by way of a key.
     * @param $key  The string identifier associated with the style sheet.
     * @return  The style sheet referenced by the key.
     */
    public function getStyleSheet( $key :String ) :StyleSheet
    {
      return StyleSheet( _map.get( $key ) );
    }

    /**
     * Returns a <code>TextFormat</code> by way of a key.
     * @param $key  The string identifier associated with the text format object.
     * @return  The text format object referenced by the key.
     */
    public function getTextFormat( $key :String ) :TextFormat
    {
      return TextFormat( _map.get( $key ) );
    }

    /**
     * Returns a generic style object by way of a key.
     * @param $key  The string identifier associated with the generic object.
     * @return  The style sheet referenced by the key.
     */
    public function getGenericStyle( $key :String ) :*
    {
      return _map.get( $key );
    }

    /**
     * Removes a style from the <code>Map</code>.
     * @param $key  The string identifier for the style to be removed.
     */
    public function removeStyle( $key :String ) :void
    {
      if( _map.hasKey( $key ) )
        _map.remove( $key );
    }

    /**
     * Make them all go away... far, far, away.
     */
    public function clear() :void
    {
      for each( var css :StyleSheet in _map.values )
      {
        try
        {
          StyleSheet( css ).clear();
        }
        catch( $e :String ){};
      }
      _map.dispose();
    }

    /**
     * Utility method for converting <code>XML</code> into a <code>StyleSheet<code>.
     * @param $xml  The xml to convert.
     * @return  The converted xml as a style sheet.
     */
    public function parseXMLToCSS( $xml :XML ) :StyleSheet
    {
      var css :StyleSheet = new StyleSheet();
      css.parseCSS( $xml );
      if( css.styleNames.length <= 0 )
        throw new Error( '[FStyleManager].parseXMLToCSS() => The CSS XML appears to be malformed.' );
      return css;
    }

    /**
     * Utility method for converting a <code>String</code> into a <code>StyleSheet<code>.
     * @param $str  The string to convert.
     * @return  The converted string as a style sheet.
     */
    public function parseStringToCSS( $str :String ) :StyleSheet
    {
      var css :StyleSheet = new StyleSheet();
      css.parseCSS( $str );
      if( css.styleNames.length <= 0 )
        throw new Error( '[FStyleManager].parseStringToCSS() => The CSS string appears to be malformed.' );
      return css;
    }
  }
}



package com.factorylabs.orange.core.utils
{
  import flash.system.Capabilities;

  /**
   * TODO: We need to figure out where this came from and give props to them – Need to check with Gabe – MK.
   * TODO: Format the ASDocs for this thing and look at cleaning it up some, it's messy – MK.
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
   * @author    ??
   * @version   1.0.0 :: ??
   */
  public final class Locale
  {
      public static const ENGLISH:String = "en";
      public static const SPANISH:String = "es";
      public static const FRENCH:String = "fr";
      public static const GERMAN:String = "de";
      public static const JAPANESE:String = "jp";
      public static const CHINESE:String = "zh";
      public static const US:String = "US";
      public static const UK:String = "UK";

      // Create private properties to store the language and variant for the locale.
      private var _sLanguage:String;
      private var _sVariant:String;

      // Create private static properties to store the global language and variant settings.
      private static var __sLanguage:String;
      private static var __sVariant:String;

      // Create getter and setter methods for the global static language and variant settings.
      public static function get slanguage():String {
        return __sLanguage;
      }

      public static function set slanguage(sLanguage:String):void {
        __sLanguage = sLanguage;
      }

      public static function get svariant():String {
        return __sVariant;
      }

      public static function set svariant(sVariant:String):void {
        __sVariant = sVariant;
      }

      // Create getter and setter methods for the language and variant settings.
      public function get language():String {

        // If the language is undefined, check to see if the global language
        // is defined. If so, use that. Otherwise, retreive the language from
        // the System.capabilities.language property.
        if(_sLanguage == null) {
          if(Locale.slanguage == null) {
            _sLanguage = Capabilities.language.substr(0, 2);
          }
          else {
            _sLanguage = Locale.slanguage;
          }
        }
        return _sLanguage;
      }

      public function set language(sLanguage:String):void {
        _sLanguage = sLanguage;
      }

      public function get variant():String {

        // As with the language setting, check to see if the variant is
        // undefined. If so, first try to use the global setting. Otherwise,
        // retrieve the value from the System.capapbilities.language property.
        // For some languages, attempt to localize based on timezone offset.
        if(_sVariant == null) {
          if(Locale.svariant == null) {
            if(Capabilities.language.length > 2) {
              _sVariant = Capabilities.language.substr(3);
            }
            else if(language == ENGLISH) {
              if(new Date().getTimezoneOffset() > 120) {
                _sVariant = US;
              }
              else {
                _sVariant = UK;
              }
            }
            else if(language == SPANISH) {
              if(new Date().getTimezoneOffset() > 120) {
                _sVariant = "MX";
              }
              else {
                _sVariant = "ES";
              }
            }
          }
          else {
            _sVariant = Locale.svariant;
          }
        }
        return _sVariant;
      }

      public function set variant(sVariant:String):void {
        _sVariant = sVariant;
      }

      // Create getter and setter methods for a single languageVariant string.
      // The string is comprised of the language and variant strings.
      public function get languageVariant():String {
        var sLanguageVariant:String = language;
        if(variant != null) {
          sLanguageVariant += "-" + variant;
        }
        return sLanguageVariant;
      }

      public function set languageVariant(sLanguageVariant:String):void {
        var aParts:Array = sLanguageVariant.split("-");
        _sLanguage = aParts[0];
        _sVariant = aParts[1];
      }

      // Create a global, static languageVariant string.
      public static function get slanguageVariant():String {
        var sLanguageVariant:String = slanguage;
        if(svariant != null) {
          sLanguageVariant += "-" + svariant;
        }
        return sLanguageVariant;
      }

      public static function set slanguageVariant(sLanguageVariant:String):void {
        var aParts:Array = sLanguageVariant.split("-");
        __sLanguage = aParts[0];
        __sVariant = aParts[1];
      }

      public function Locale(sLanguage:String = null, sVariant:String = null) {
        _sLanguage = sLanguage;
        _sVariant = sVariant;
      }

      // Define reset and global, static reset methods.
      public function reset():void {
        language = null;
        variant = null;
      }

      public static function sreset():void {
        __sLanguage = null;
        __sVariant = null;
      }
  }
}


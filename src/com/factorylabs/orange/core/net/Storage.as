
package com.factorylabs.orange.core.net
{
  import org.osflash.signals.Signal;

  import flash.events.NetStatusEvent;
  import flash.net.SharedObject;
  import flash.net.SharedObjectFlushStatus;

  /**
   * The Storage class is used to read and store limited amounts of data on a user's computer through the Local Shared Object (LSO).
   *
   * <p>LSOs offer real-time data sharing between objects that are persistent on the user's computer. A LSO is similar to a browser cookie.
   * For more information see the language reference for the SharedObject class.
   *
   * !- The flush method is not necessarily needed. The swf will flush the file when the user exits the site so we only call it when it is critical to the architecture.</p>
   *
   * Copyright 2007 by Factory Design Labs, All Rights Reserved.
   * <a href="http://www.factorylabs.com/">www.factorylabs.com</a>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Nov 2, 2007
   * @version   1.5.0 :: March 6, 2009 :: Changed from inheritance to composition based with EventDispatcher, added a default namespace, added try catch statements around the flush calls.
   *
   * @example The following code creates an instance of storage.
   * <listing version="3.0" >
   * _storage = Storage.getInstance();
   * _storage.getLocal( _config.namespace );
   * </listing>
   */
  public class Storage
  {
/*
 * PROPERTIES
**************************************************************************************************** */

    /**
     * @private
     */
    private var _name       :String;

    /**
     * @private
     */
    private var _localPath      :String;

    /**
     * @private
     */
    private var _secure       :Boolean;

    /**
     * @private
     */
    private var _so         :SharedObject;

    /**
     * The object used for dispatching LSO conditions.
     */
    private var _netStatus      :Signal;

/*
 * PROPERTY ACCESS
**************************************************************************************************** */

    /**
     * @return  The name of the object. The name can include forward slashes (/); for example, work/addresses is a legal name. Spaces are not allowed in a shared object name, nor are the following characters:  ~ % & \ ; : " ' , < > ? #
     */
    public function get name() :String { return _name; }
    public function set name( $name :String ) :void { _name = $name; }

    /**
     * @return  The full or partial path to the SWF file that created the shared object, and that determines where the shared object will be stored locally. If you do not specify this parameter, the full path is used.
     */
    public function get localPath() :String { return _localPath; }
    public function set localPath( $localPath :String ) :void { _localPath = $localPath; }

    /**
     * @return Determines whether access to this shared object is restricted to SWF files that are delivered over an HTTPS connection.
     */
    public function get secure() :Boolean { return _secure; }
    public function set secure( $secure :Boolean ) :void { _secure = $secure; }

    /**
     * @return The accessor for the <code>NetStatusEvent.NET_STATUS Signal</code>.
     */
    public function get netStatus() :Signal { return _netStatus; }

    /**
     * @return  The entire shared data object being stored (to see the values loop through the "data" property of the LSO).
     */
    public function get lso() :SharedObject { return _so; }
/*
 * CONSTRUCTOR
**************************************************************************************************** */

    /**
     * Initialization for retrieving the local shared object associated with the application.
     * @param name      The name of the object. The name can include forward slashes (/); for example, work/addresses is a legal name. Spaces are not allowed in a shared object name, nor are the following characters:  ~ % & \ ; : " ' , < > ? #
     * @param localPath   The full or partial path to the SWF file that created the shared object, and that determines where the shared object will be stored locally. If you do not specify this parameter, the full path is used.
     * @param secure    Determines whether access to this shared object is restricted to SWF files that are delivered over an HTTPS connection.
     */
    public function Storage( $name :String = 'default.name', $localPath :String = null, $secure :Boolean = false )
    {
      _name = $name;
      _localPath = $localPath;
      _secure = $secure;

      initialize();
    }

    /**
     * @return  the string equivalent of this class.
     */
    public function toString() :String
    {
      return "com.factorylabs.core.net.Storage";
    }

/*
 * INTERNAL ACCESS
**************************************************************************************************** */

    /**
     * Initialization for retrieving the local shared object associated with the application.
     */
    private function initialize() : void
    {
      _netStatus = new Signal( NetStatusEvent );
      try
      {
        _so = SharedObject.getLocal( _name, _localPath, _secure );
      }
      catch( err :Error )
      {
//        Log.error( 'ERROR :: [Storage].getLocal() :: ' + err.toString() );
      }
    }

/*
 * PUBLIC ACCESS
**************************************************************************************************** */

    /**
     * Save a property and its value into the "data" object within the LSO.
     * @param property  string name of the property to save.
     * @param value   value of the property.
     */
    public function save( $property :String, $value :Object ) :void
    {
      try
      {
        _so.data[ $property ] = $value;
      }
      catch( err :Error )
      {
//        Log.error( 'ERROR :: [Storage].save() :: ' + err.toString() );
      }
    }

    /**
     * Get the value of a property within the data object of the LSO.
     * @param   property  name of the properties value to retrieve.
     * @return  the properties value.
     */
    public function retrieve( $property :String ) :*
    {
      return _so == null ? null : _so.data[ $property ];
    }

    /**
     * Clear out a specific property within the LSO.
     * @param property  name of the property to clear out.
     */
    public function erase( $property :String ) :void
    {
      delete _so.data[ $property ];
      flush();
    }

    /**
     * Deletes all information stored in the LSO.
     */
    public function clear() :void
    {
      _so.clear();
    }

    /**
     *  Immediately writes a locally persistant shared object to a .sol file.
     *  <p>Only need to call when storing large amounts of data or prior to deleting the instance or all references of Storage.
     *  When calling this method it is highly recommended to add an event listener for the NetStatusEvent.
     *  If the data occupies more than the allotted space, the user will be presented with the option to allow or deny.
     *  If this is the case a status of PENDING will be issued while the user decides.
     *  Once the user decides, Storage will dispatch that decision from the onFlushStatus method.
     *  If the data can be saved without incident, that will be denoted from info.code object broadcast from here.</p>
     *  @param  minDiskSpace  [Optional] kb in alloted disk space. only send for large .sol files.
     */
    public function flush( $minDiskSpace :int = 0 ) :void
    {
      try
      {
        var vStatus :String = _so.flush( $minDiskSpace );
      }
      catch( err1 :Error )
      {
//        Log.error( 'ERROR :: [Storage].flush() :: ' + err1.toString() );
      }

      onFlushStatus( new NetStatusEvent( NetStatusEvent.NET_STATUS, false, false, { code: vStatus } ) );

      if( vStatus == SharedObjectFlushStatus.PENDING )
      {
        _so.addEventListener( NetStatusEvent.NET_STATUS, onFlushStatus );
      }
    }
/*
 * EVENT HANDLING
**************************************************************************************************** */

    /**
     * Captures and re-dispatches the NetStatusEvent associated with the result from the PENDING call applied from the flush method after a user decides.
     * @param event string value wrapped in the "event.info.code" as either "SharedObject.Flush.Success" or "SharedObject.Flush.Failed".
     */
    private function onFlushStatus( $e :NetStatusEvent ) :void
    {
      netStatus.dispatch( $e );
    }
/*
 * EVENT DISPATCHER HOOKS
**************************************************************************************************** */
  }
}


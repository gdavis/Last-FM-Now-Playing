
package com.factorylabs.orange.core.net
{
  import com.factorylabs.orange.core.IDisposable;
  import com.factorylabs.orange.core.collections.Map;

  import org.osflash.signals.Signal;

  import flash.display.Loader;
  import flash.utils.getTimer;

  /**
   * LoaderManager is a robust loading tool which provides a simple API
   * to perform complex loading requirements easy and fast.
   *
   * <p>This class allows multiple loads to be queued and prioritized for sequential loading.</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Grant Davis
   * @version   1.0.0 :: Feb 8, 2008
   * @version   1.1.0 :: Feb 24, 2010 - Converted dispatched events to Signals
   */
  public class LoaderManager
    implements IDisposable
  {
/* Properties ......................................................................................*/

    /**
     * @private
     */
    private var _errorSignal      :Signal;
    /**
     * @private
     */
    private var _progressSignal     :Signal;
    /**
     * @private
     */
    private var _overallProgressSignal  :Signal;
    /**
     * @private
     */
    private var _pausedSignal     :Signal;
    /**
     * @private
     */
    private var _loadStartSignal    :Signal;
    /**
     * @private
     */
    private var _completeSignal     :Signal;
    /**
     * @private
     */
    private var _allCompleteSignal    :Signal;
    /**
     * @private
     */
    private var _itemAddedSignal    :Signal;

    /**
     * Dictionary which stores all LoadItems.
     */
    private var _itemMap:Map;

    /**
     * Array to store all the LoadItems managed by this class.
     */
    private var _loadItems:Array;

    /**
     * Number of items which still need to be loaded.
     */
    private var _remainingItems:int;

    /**
     * Total number of items added to management.
     */
    private var _totalItems:int;

    /**
     * Number of items which have successfully completed loading.
     */
    private var _loadedItems:int;

    /**
     * Number of maximum allowed concurrent downloads.
     */
    private var _maxConnections:uint;

    /**
     * Array of LoadItems which are currently loading.
     */
    private var _openConnections:Array;

    /**
     * Flag indicated whether the LoaderManager has completely
     * finished loading all of its items.
     */
    private var _isFinished:Boolean;

    /**
     * Active bandwidth for user loads, in Kbps.
     */
    private var _bandwidth:uint;

    /**
     * Percentage of bytes currently loaded. This only tracks open connects or completed connections
     * since the bytesLoaded and bytesTotal properties are not available until a download has started.
     */
    private var _bytePercent:Number;

    /**
     * Stores the time at which the start() method was called. Used to calculate
     * elapsed and remaining time values.
     */
    private var _startTime:int;

    /**
     * Total number of bytes from all managed LoadItems.
     */
    private var _totalBytes:int;

    /**
     * Number of loaded bytes from all managed LoadItems.
     */
    private var _loadedBytes:int;

    /**
     * Number of downloads which have failed to successfully complete.
     */
    private var _failed:int;

    /**
     * Average latency calcualted from all managed LoadItems. Stored in miliseconds.
     */
    private var _averageLatency:int;

    /**
     * Stores each created LoadItem as they key with its priority value.
     */
    private var _priorityMap  :Map;

/* Getters/Setters ......................................................................................*/

    /**
     * @return The Signal that dispatches error messages.
     *
     * <p>The handler method for this signal needs two parameters; a LoadItem and String.</p>
     *
     * <listing version="3.0">
     * _loaderManager.errorSignal.add( myCallback );
     *
     * function myCallback( $loader : LoadItem, $errorMessage : String ) :void
     * {
     *    {...}
     * }
     * </listing>
     */
    public function get errorSignal() :Signal { return _errorSignal; }
    /**
     * @return The Signal that dispatches progress updates from individual LoadItems.
     *
     * <p>The handler method for this signal needs three parameters; a LoadItem, and two uint values for bytesLoaded and bytesTotal./p>
     *
     * <listing version="3.0">
     * _loaderManager.progressSignal.add( myCallback );
     *
     * function myCallback( $loader : LoadItem, $bytesLoaded : uint, $bytesTotal : uint ) :void
     * {
     *    {...}
     * }
     * </listing>
     */
    public function get progressSignal() :Signal { return _progressSignal; }
    /**
     * @return The Signal that dispatches the overall load progress of the LoaderManager as a percentage from 0-1.
     *
     * <p>The handler method for this signal needs a single parameter; a Number representing the overall percent loaded (from 0-1)./p>
     *
     * <listing version="3.0">
     * _loaderManager.overallProgressSignal.add( myCallback );
     *
     * function myCallback( $loader : LoadItem, $percentLoaded : Number ) :void
     * {
     *    {...}
     * }
     * </listing>
     */
    public function get overallProgressSignal() :Signal { return _overallProgressSignal; }
    /**
     * @return The Signal that dispatches when the pauseAll() or pause() methods are called.
     *
     * <p>The handler method for this signal does not require any paramters./p>
     *
     * <listing version="3.0">
     * _loaderManager.pausedSignal.add( myCallback );
     *
     * function myCallback() :void
     * {
     *    {...}
     * }
     * </listing>
     */
    public function get pausedSignal() :Signal { return _pausedSignal; }
    /**
     * @return The Signal that dispatches when a LoadItem has begun receiving bytes.
     *
     * <p>The handler method for this signal requires a single LoadItem as the function parameter./p>
     *
     * <listing version="3.0">
     * _loaderManager.loadStartSignal.add( myCallback );
     *
     * function myCallback( $loader : LoadItem ) :void
     * {
     *    {...}
     * }
     * </listing>
     */
    public function get loadStartSignal() :Signal { return _loadStartSignal; }
    /**
     * @return The Signal that dispatches when a LoadItem has successfully completed loading.
     *
     * <p>The handler method for this signal requires a single LoadItem as the function parameter./p>
     *
     * <listing version="3.0">
     * _loaderManager.completeSignal.add( myCallback );
     *
     * function myCallback( $loader : LoadItem ) :void
     * {
     *    {...}
     * }
     * </listing>
     */
    public function get completeSignal() :Signal { return _completeSignal; }
    /**
     * @return The Signal that dispatches when all items added to the LoaderManager have successfully completed.
     *
     * <p>The handler method for this signal does not require any paramters./p>
     *
     * <listing version="3.0">
     * _loaderManager.allCompleteSignal.add( myCallback );
     *
     * function myCallback() :void
     * {
     *    {...}
     * }
     * </listing>
     */
    public function get allCompleteSignal() :Signal { return _allCompleteSignal; }
    /**
     * @return The Signal that dispatches when a new LoadItem is added to the LoaderManager.
     *
     * <p>The handler method for this signal requires a single LoadItem as the function parameter./p>
     *
     * <listing version="3.0">
     * _loaderManager.itemAddedSignal.add( myCallback );
     *
     * function myCallback( $loader : LoadItem ) :void
     * {
     *    {...}
     * }
     * </listing>
     */
    public function get itemAddedSignal() :Signal { return _itemAddedSignal; }

    /**
     * @return  the total number of concurrent connections that can be open at once.
     */
    public function get maxConnections() :uint { return _maxConnections; }

    /**
     * @return  the number of total items being managed.
     */
    public function get total():int { return _totalItems; }

    /**
     * @return  the number of items remaining to be loaded.
     */
    public function get remaining():int { return _remainingItems; }

    /**
     * @return  a copy of the internally stored array of load items.
     */
    public function get loadItems():Array { return cloneArray( _loadItems ); }

    /**
     * @return  the number of currently active connections.
     */
    public function get connections():int { return _openConnections.length; }

    /**
     * @return  the number of finished LoadItems.
     */
    public function get isFinished():Boolean { return _isFinished; }

    /**
     * @return  the current active bandwidth of all open connections, in Kbps.
     */
    public function get bandwidth():uint { return _bandwidth; }

    /**
     * @return  the average latency of all loads, in miliseconds.
     */
    public function get averageLatency():uint { return _averageLatency; }

    /**
     * @return  the current percent of bytes which have been loaded. Number is from 0-1.
     */
    public function get percentLoaded():Number { return _bytePercent; }

    /**
     * @return  the number of failed loads.
     */
    public function get failed():int { return _failed; }

    /**
     * @return  the number of items which have completed loading.
     */
    public function get loaded():int { return  _loadedItems; }

    /**
     * @return  the ratio of loaded items over total items in the manager.
     */
    public function get ratioLoaded():Number { return this.loaded / this.total; }

    /**
     * @return  the LoadItem with the highest priority. if two items have the same priority, the
     * item added to the manager first will take precedence.
     */
    public function get highestPriority():int
    {
      var highest:int = int.MIN_VALUE;
      var dl:uint = _loadItems.length;
      var priority : int;
      for( var i:int=0; i < dl; i++ )
      {
        var item:LoadItem = _loadItems[ i ];
        priority = _priorityMap.get( item );
        if ( priority > highest ) highest = priority;
      }
      return highest;
    }

    /**
     * @return  the amount of seconds that have elapsed since loading began.
     */
    public function get elapsedTime():Number
    {
      return LoadItem.truncateNumber(( getTimer() - _startTime ) / 1000, 2 );
    }


/* Constructor ......................................................................................*/

    /**
     * Builds an instance of the LoaderManager.
     *
     * @param maxConnections  the max number of allowed concurrent downloads.
     */
    public function LoaderManager( $maxConnections:uint=2 )
    {
      if ( $maxConnections < 1 ) throw new Error( "[LoaderManager] Error: You must use at least one connection" );
      _maxConnections = $maxConnections;
      initialize();
    }

/* Public Methods .....................................................................................*/

    /**
     * Adds an external load to the manager.
     *
     * @param key     an untyped data value which is used to store the new LoadItem by. this key is used as a unique identifier for that
     *            load. if a key already exists in our local storage, the add will fail to complete.
     * @param request     a URLRequest object for the file to load.
     * @param priority    a integer value which determines the priority of this item. higher priority values are loaded before lower values.
     * @param LoaderType  [Optional] a Loader subclass to use as the Loader for this item. For example, you could pass "ImageLoader", a subclass of Loader,
     *            to perform the load in place of a generic Loader object.
     * @param context   [Optional] a LoaderContext object to use for this load.
     * @return        A boolean indiciating if the item was successfully added (true) or failed to add (false).
     */
    public function add( $key:*, $loader : LoadItem, $priority : int = 0 ):Boolean
    {
      if ( _itemMap.hasKey( $key ))
      {
        throw new Error( "An item already exists with the key: " + $key + "." );
        return false;
      }

      _priorityMap.add( $loader, $priority );

      addListeners( $loader );
      addItem( $key, $loader );

      _itemAddedSignal.dispatch( $loader );
      return true;
    }

    /**
     * Performs an immediate load which bypasses priority.
     *
     * Use this method when a file must be loaded immediatley, without waiting for previously added loads to complete first.
     *
     * @param key     an untyped data value which is used to store the new LoadItem by. this key is used as a unique identifier for that
     *            load. if a key already exists in our local storage, the add will fail to complete.
     * @param request     a URLRequest object for the file to load.
     * @param pauseOthers [Optional] flag determining whether other currently open and active downloads should be paused while loading this item.
     * @param LoaderType  [Optional] a Loader subclass to use as the Loader for this item. For example, you could pass "ImageLoader", a subclass of Loader,
     *            to perform the load in place of a generic Loader object.
     * @param context   [Optional] a LoaderContext object to use for this load.
     * @return        A boolean indiciating if the item was successfully added (true) or failed to add (false).
     */
    public function loadNow( $key:*, $loader : LoadItem, $pauseOthers : Boolean = false ) :Boolean
    {
      if( _itemMap.hasKey( $key ))
      {
        throw new Error( "An item already exists with the key: " + $key + "." );
        return false;
      }

      if ( $pauseOthers )
      {
        $loader.completeSignal.add( onResume );
        $loader.errorSignal.add( onResume );
        pauseAll();
      }

      _priorityMap.add( $loader, uint.MAX_VALUE );

      addListeners( $loader );
      addItem( $key, $loader );

      // lose lowest priority connection if we are over the allowed amount.
      if( this.connections+1 > _maxConnections )
        closeConnection( getLowestPriorityActiveItem() );

      // open the connection, now!
      openNewConnection( $loader );

      _itemAddedSignal.dispatch( $loader );
      return true;
    }

    /**
     * Performs an immediate load on an item that has already been added to the manager, which bypasses priority.
     *
     * Use this method when a file must be loaded immediatley, without waiting for
     * previously added loads to complete first.
     *
     * @param key     an untyped data value which is used to store the new LoadItem by. this key is used as a unique identifier for that
     *            load. if a key already exists in our local storage, the add will fail to complete.
     * @param request     a URLRequest object for the file to load.
     * @param pauseOthers [Optional] flag determining whether other currently open and active downloads should be paused while loading this item.
     * @param LoaderType  [Optional] a Loader subclass to use as the Loader for this item. For example, you could pass "ImageLoader", a subclass of Loader,
     *            to perform the load in place of a generic Loader object.
     * @param context   [Optional] a LoaderContext object to use for this load.
     * @return        A boolean indiciating if the LoadItem was successfully started.
     */
    public function loadNowByKey( $key:*, $pauseOthers:Boolean=false ):Boolean
    {
      // fail if we don't have an object by that key.
      if ( !_itemMap.hasKey( $key )) return false;

      var item:LoadItem = _itemMap.get( $key ) as LoadItem;
      _priorityMap.add( item, uint.MAX_VALUE, true );

      if ( $pauseOthers )
      {
        item.completeSignal.add( onResume );
        item.errorSignal.add( onResume );
        pauseAll();
      }

      // lose lowest priority connection if we are over the allowed amount.
      if( this.connections+1 > _maxConnections )
        closeConnection( getLowestPriorityActiveItem() );

      // open the connection now if its idle.
      if ( item.state == LoadItem.STATE_IDLE )
        openNewConnection( item );

      // resume load if its paused.
      else if ( item.state == LoadItem.STATE_PAUSED )
        resume( $key );

      // otherwise we fail to load because the state must be either complete, failed or already loading.
      else return false;

      _itemAddedSignal.dispatch( item );

      return true;
    }

    /**
     * Begins loading all items added to the manager.
     */
    public function start():void
    {
      loadConnections();
      _startTime = getTimer();
    }

    /**
     * Cancels and removes a LoadItem from management.
     *
     * @param key untyped data object which is used to reference the LoadItem created when add() or loadNow() were called.
     */
    public function cancel( $key:* ):void
    {
      if ( !_itemMap.hasKey( $key )) return;

      var item:LoadItem = _itemMap.get( $key );

      closeConnection( item );

      item.dispose();
      remove( $key );

      _totalItems = _loadItems.length;
      _remainingItems = _totalItems - _loadedItems;

      checkNext();
    }

    /**
     * Cancels all items added to the manager.
     */
    public function cancelAll():void
    {
      var keys:Array = _itemMap.keys;
      for (var i:Number=0; i < keys.length; i++)
      {
        var key:* = keys[ i ];
        cancel( key );
      }
    }

    /**
     * Cancels and removes any LoadItems which have failed to load.
     */
    public function cancelFailedItems():void
    {
      var keys:Array = _itemMap.keys;
      for (var i:Number = 0; i < keys.length; i++)
      {
        var key:* = keys[ i ];
        var item:LoadItem = getLoadItem( key );
        if ( item.state == LoadItem.STATE_ERROR )
          cancel( key );
      }
    }

    /**
     * Pauses a currently active download.
     * @param key untyped data object which is used to reference the LoadItem created when add() or loadNow() were called.
     */
    public function pause( $key:* ):void
    {
      if ( $key == null ) return;
      var item:LoadItem = _itemMap.get( $key );
      if ( item.state == LoadItem.STATE_OPEN || item.state == LoadItem.STATE_CONNECTING  )
      {
        item.pause();
        _pausedSignal.dispatch();
      }
    }

    /**
     * Pauses all open connections currently downloading.
     */
    public function pauseAll():void
    {
      var item : LoadItem;
      for( var i:int = 0; i < _openConnections.length ; i++ )
      {
        item = _openConnections[ i ];
        if ( item.state == LoadItem.STATE_OPEN || item.state == LoadItem.STATE_CONNECTING )
        {
          item.pause();
        }
      }
      _pausedSignal.dispatch();
    }

    /**
     * Resumes downloading of a particular item.
     * @param key untyped data object which is used to reference the LoadItem created when add() or loadNow() were called.
     */
    public function resume( $key:* ):void
    {
      if ( $key == null ) return;
      var item:LoadItem = _itemMap.get( $key );
      if ( item.state == LoadItem.STATE_PAUSED )
         item.start();
    }

    /**
     * Resumes loading of all LoadItems which have been paused.
     */
    public function resumeAll():void
    {
      for( var i:int=0; i<_openConnections.length; i++ )
      {
        var item:LoadItem = _openConnections[ i ];
        if( item.state == LoadItem.STATE_PAUSED )
          item.start();
      }
    }

    /**
     * Finds and returns the LoadItem associated with the specified key value.
     *
     * @param key untyped data object which is used to reference the LoadItem created when add() or loadNow() were called.
     * @return  the LoadItem associated with the specified key.
     */
    public function getLoadItem( $key:* ):LoadItem
    {
      return _itemMap.get( $key ) as LoadItem;
    }

    /**
     * Finds and returns the key used to store a particlar LoadItem.
     * Handy for reverse lookup when abstractly handling load events.
     *
     * @param item  The LoadItem you wish you return the stored key for.
     */
    public function getKeyByLoadItem( $item:LoadItem ) : *
    {
      var keys:Array = _itemMap.keys;
      var kl:int = keys.length;
      var key:*;
      for ( var i : Number = 0; i < kl; i++ )
      {
        var storedKey:* = keys[ i ];
        var storedItem:LoadItem = _itemMap.get( storedKey );
        if ( storedItem == $item )
        {
          key = storedKey;
          break;
        }
      }
      return key;
    }

    /**
     * Checks to see if there are any idle loads in the manager.
     *
     * @return  a boolean value indicated whether or not the manager has idle items in the queue.
     */
    public function hasIdleItems():Boolean
    {
      return ( getNextIdleItem() == null ) ? false : true;
    }

    /**
     * Checks to see if there are any paused loads out there that we can
     * start loading.
     *
     * @return  a boolean value indicated whether or not the manager has paused items in the queue.
     */
    public function hasPausedItems():Boolean
    {
      return ( getNextPausedItem() == null ) ? false : true;
    }

    /**
     * Performs cleanup and destroy operations to prepare this class for garbage collection.
     */
    public function dispose():void
    {
      _errorSignal.removeAll();
      _progressSignal.removeAll();
      _overallProgressSignal.removeAll();
      _pausedSignal.removeAll();
      _loadStartSignal.removeAll();
      _completeSignal.removeAll();
      _allCompleteSignal.removeAll();
      _itemAddedSignal.removeAll();

      var dl : uint = _loadItems.length;
      var item : LoadItem;
      for( var i:int = 0; i < dl; i++ )
      {
        item = _loadItems[ i ];
        removeListeners( item );
        item.dispose();
        item = null;
      }

      _priorityMap.dispose();
      _itemMap.dispose();
      _loadItems.length = 0;
      _openConnections.length = 0;
      _loadItems = null;
      _openConnections = null;
      _itemMap = null;
      _priorityMap = null;
      _errorSignal = null;
      _progressSignal = null;
      _overallProgressSignal = null;
      _pausedSignal = null;
      _loadStartSignal = null;
      _completeSignal = null;
      _allCompleteSignal = null;
      _itemAddedSignal = null;
    }

    /**
     * @return  the string value of this class and package name.
     */
    public function toString():String
    {
      return "[com.factorylabs.components.net.LoaderManager]";
    }

/* Private Methods ......................................................................................*/

    /**
     * Initializes the manager when first created.
     */
    protected function initialize():void
    {
      _itemMap = new Map();
      _priorityMap = new Map();
      _loadItems = [];
      _openConnections = [];
      _totalItems = 0;
      _remainingItems = 0;
      _failed = 0;
      _isFinished = false;
      buildSignals();
    }

    /**
     * @private
     */
    protected function buildSignals() :void
    {
      _errorSignal = new Signal( LoadItem, String );
      _progressSignal = new Signal( LoadItem, uint, uint );
      _overallProgressSignal = new Signal( Number );
      _pausedSignal = new Signal();
      _loadStartSignal = new Signal( LoadItem );
      _completeSignal = new Signal( LoadItem );
      _allCompleteSignal = new Signal();
      _itemAddedSignal = new Signal( LoadItem );
    }

    /**
     * Adds a new LoadItem to the management.
     * @param key an untyped data object used to reference the LoadItem from a Map.
     * @param item  the LoadItem to add to management with the associated key.
     */
    protected function addItem( $key:*, $item:LoadItem ):void
    {
      _isFinished = false;
      _itemMap.add( $key, $item );
      _loadItems.unshift( $item );
      _loadItems.sort( sortByPriority );
      _totalItems = _loadItems.length;
      _remainingItems = _totalItems - _loadedItems;
    }

    /**
     * Opens the next connection in line.
     */
    protected function next():void
    {
      if ( this.connections >= _maxConnections ) return;
      var nextItem:LoadItem = getNextIdleItem();
      openNewConnection( nextItem );
    }

    /**
     * Performs final steps when the manager has completed all loads.
     */
    protected function complete():void
    {
      _isFinished = true;
      _allCompleteSignal.dispatch();
    }

    /**
     * Checks to see if there can be more connections created or if its finished.
     */
    protected function checkNext():void
    {
      if ( hasIdleItems() ) loadConnections();
      else if (( this.failed + this.loaded ) == this.total ) complete();
    }

    /**
     * Creates new connections until the max connection limit is reached.
     */
    protected function loadConnections():void
    {
      while( this.connections < _maxConnections )
      {
        if ( hasIdleItems()) next();
        else break;
      }
    }

    /**
     * Opens a new connection with the specified LoadItem.
     * @param item  LoadItem to start loading.
     */
    protected function openNewConnection( $item:LoadItem ):void
    {
      _openConnections.push( $item );
      _openConnections.sortOn( sortByPriority );
      $item.start();
    }

    /**
     * Closes a currently active open connection.
     * @param item  LoadItem to stop and close the connection of.
     * @return    A boolean flag inidicated whether the close completely successfully.
     */
    protected function closeConnection( $item:LoadItem ):Boolean
    {
      if ( $item.state != LoadItem.STATE_COMPLETE && $item.state != LoadItem.STATE_ERROR ) $item.stop();
      for( var i:int=0; i<_openConnections.length; i++ )
      {
        var tempItem:LoadItem = _openConnections[ i ];
        if ( tempItem.loader == $item.loader )
        {
          _openConnections.splice( i, 1 );
          return true;
        }
      }
      return false;
    }

    /**
     * Removes a LoadItem from managment.
     * @param key Untyped data object associated with the LoadItem to remove.
     * @return    A boolean flag inidicated whether the remove completely successfully.
     */
    protected function remove( $key:* ):Boolean
    {
      var item:LoadItem = _itemMap.get( $key );

      if ( item == null ) return false;
      _itemMap.remove( $key );
      _priorityMap.remove( item );

      var dl : uint = _loadItems.length;
      for( var i:int=0; i<dl; i++ )
      {
        var tempItem:LoadItem = _loadItems[ i ];
        if ( tempItem == item )
        {
          _loadItems.splice( i, 1 );
          return true;
        }
      }
      return false;
    }

    /**
     * Closes the connection of a load which has just completed. Also removes listeners
     * associated with the LoadItem no more listeners for this object are needed.
     * @return    A boolean flag inidicated whether the remove completely successfully.
     */
    protected function removeCompleted( $loadItem:LoadItem ):Boolean
    {
      removeListeners( $loadItem );
      return closeConnection( $loadItem );
    }


    /**
     * Adds LoadItemEvent listeners to a LoadItem.
     * @param loadItem  The LoadItem to listen to events from.
     */
    protected function addListeners( $loader : LoadItem ):void
    {
      $loader.openSignal.addOnce( onOpen );
      $loader.progressSignal.addOnce( onProgress );
      $loader.completeSignal.addOnce( onLoadComplete );
      $loader.errorSignal.addOnce( onError );
    }

    /**
     * Removes LoadItemEvent listeners from a LoadItem.
     * @param loadItem  The LoadItem to remove events from.
     */
    protected function removeListeners( $loader : LoadItem ):void
    {
      $loader.openSignal.remove( onOpen );
      $loader.progressSignal.remove( onProgress );
      $loader.completeSignal.remove( onLoadComplete );
      $loader.errorSignal.remove( onError );
    }

    /**
     * @return the first available LoadItem that is in an idle state.
     */
    protected function getNextIdleItem():LoadItem
    {
      for( var i:int=0; i<_loadItems.length; i++ )
      {
        var item:LoadItem = _loadItems[ i ];
        if( item.state == LoadItem.STATE_IDLE ) return item;
      }
      return null;
    }

    /**
     * @return  the first available LoadItem that is in an idle state.
     */
    protected function getNextPausedItem():LoadItem
    {
      for( var i:int=0; i<_loadItems.length; i++ )
      {
        var item:LoadItem = _loadItems[ i ];
        if( item.state == LoadItem.STATE_PAUSED ) return item;
      }
      return null;
    }

    /**
     * @return  the lowest priority of the open connections.
     */
    protected function getLowestPriorityActiveItem():LoadItem
    {
      return _openConnections[ _openConnections.length-1 ] as LoadItem;
    }

    /**
     * @return  the associated LoadItem with a particular Loader instance. returns null if none found.
     */
    protected function getLoadItemFromLoader( $loader:Loader ):LoadItem
    {
      for( var i:int = 0; i < _loadItems.length ; i++ )
      {
        var item:LoadItem = _loadItems[ i ];
        if ( item.loader == $loader )
        {
          return item;
        }
      }
      return null;
    }


    /**
     * Sorts an array based on the priority property from highest to lowest.
     */
    protected function sortByPriority( $a:LoadItem, $b:LoadItem ):int
    {
      var priorityA : int = _priorityMap.get( $a );
      var priorityB : int = _priorityMap.get( $b );
      if ( priorityA > priorityB ) return -1;
      else if ( priorityA < priorityB ) return 1;
      else return 0;
    }

    /**
     * Internally updates totals and percentages of all loads.
     */
    protected function updateProgress():void
    {
      var loaded:int = 0;
      var total:int = 0;
      var percent:Number = 0;
      var numCounted:int = 0;

      for( var i:int=0; i < _loadItems.length; i++ )
      {
        var item:LoadItem = _loadItems[ i ];
        loaded += item.bytesLoaded;
        total += item.bytesTotal;


        if ( item.state != LoadItem.STATE_ERROR )
        {
          percent += item.percentLoaded;
          numCounted++;
        }
      }

      _loadedBytes = loaded;
      _totalBytes = total;
      _bytePercent = percent / numCounted;
    }

    /**
     * Internally updates the active bandwidth for all open connections.
     */
    protected function updateBandwidth():void
    {
      var activeBandwidth:int = 0;
      for( var i:int = 0; i < _openConnections.length; i++ )
      {
        var item:LoadItem = _openConnections[ i ];
        if ( item.state == LoadItem.STATE_OPEN )
        {
          activeBandwidth += item.bandwidth;
        }
      }
      // record the TOTAL bandwidth of active items.
      _bandwidth = activeBandwidth;
    }

    /**
     * Averages the latency value from all LoadItems.
     */
    protected function updateAverageLatency():void
    {
      var latencyTotal:int = 0;
      var numCounted:int = 0;
      for( var i:int=0; i<_loadItems.length; i++ )
      {
        var item:LoadItem = _loadItems[ i ];
        if ( item.state == LoadItem.STATE_PAUSED || item.state == LoadItem.STATE_OPEN || item.state == LoadItem.STATE_COMPLETE )
        {
          latencyTotal += item.latency;
          numCounted++;
        }
      }
      _averageLatency = latencyTotal / numCounted;
    }

    /**
     * Updates the number of remaining items left to load.
     */
    protected function updateRemaining():void
    {
      _remainingItems = _totalItems - ( _loadedItems + _failed );
    }

        /**
     * Creates a new unique copy of the array passed in.
     *
     * @param arr   the array to copy.
     * @return  a new array that is a complete copy of the one passed in.
     */
        private function cloneArray( $arr:Array ):Array
    {
      var array:Array = [];
      var ln:int = $arr.length;
      for ( var i : Number = 0; i < ln; i++ ) { array[ i ] = $arr[ i ]; }
      return array;
    }

/* Loader Handlers......................................................................................*/

    /**
     * Handles a loadNow() or loadNowByKey() LoadItem and resumes all queued connections after it is complete.
     * @param $loader   The LoadItem dispatching an event.
     * @param   $errorMsg [Optional] String message sent through when this function handles a LoadItem error state.
     *
     */
    protected function onResume( $loader : LoadItem, $errorMsg : String = null ):void
    {
      $loader.completeSignal.remove( onResume );
      $loader.errorSignal.remove( onResume );
      resumeAll();
    }

    /**
     * Handles a LoadItem open event, meaning the download has successfully started.
     * @param evt   Event object from dispatching class.
     */
    protected function onOpen( $loader : LoadItem ):void
    {
      updateProgress();
      updateAverageLatency();
      _loadStartSignal.dispatch( $loader );
    }

    /**
     * Handles progress events from LoadItems.
     */
    protected function onProgress( $loader : LoadItem, $bytesLoaded : uint, $bytesTotal : uint ):void
    {
      updateProgress();
      updateBandwidth();
      _progressSignal.dispatch( $loader, $bytesLoaded, $bytesTotal );
      _overallProgressSignal.dispatch( this.ratioLoaded );
    }

    /**
     * Dispatched when data has loaded successfully. Always occurs after the init event.
     * @param evt   Event object from dispatching Loader.
     */
    protected function onLoadComplete( $loader : LoadItem ):void
    {
      _loadedItems++;
      updateRemaining();
      updateProgress();
      removeCompleted( $loader );
      _completeSignal.dispatch( $loader );
      checkNext();
    }

    /**
     * Dispatched when an input or output error occurs that causes a load operation to fail
     * @param evt   Event object from dispatching Loader.
     */
    protected function onError( $loader : LoadItem, $errorText : String ):void
    {
      _failed++;
      updateRemaining();
      updateProgress();
      removeCompleted( $loader );
      checkNext();
      _errorSignal.dispatch( $loader, $errorText );
    }

  }
}


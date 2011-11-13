
package com.factorylabs.orange.core.gc
{
  import flash.media.SoundChannel;
  import flash.utils.Dictionary;

  /**
   * The JanitorSoundChannel is used for garbage collection dealing with <code>SoundChannel</code> objects.
   *
   * <p>The following people are credited with originating all or parts of this code:<br />
   * Grant Skinner :: www.gskinner.com</p>
   *
   * <hr />
   * <p><a target="_top" href="http://github.com/factorylabs/orange-actionscript/MIT-LICENSE.txt">MIT LICENSE</a></p>
   * <p>Copyright (c) 2004-2010 <a target="_top" href="http://www.factorylabs.com/">Factory Design Labs</a></p>
   *
   * <p>Permission is hereby granted to use, modify, and distribute this file
   * in accordance with the terms of the license agreement accompanying it.</p>
   *
   * @author    Matthew Kitt
   * @version   1.0.0 :: Mar 6, 2009
   */
  public class JanitorSoundChannel
    implements IJanitor
  {
    private var _target       :Object;
    private var _soundChannels    :Dictionary;

    /**
     * The <code>Dictionary</code> for storing <code>SoundChannels</code>.
     */
    public function get soundChannels() :Dictionary { return _soundChannels; }

    /**
     * Create an instance of a <code>JanitorSoundChannel</code>.
     * @param $target Target object hosting a <code>SoundChannel</code>.
     */
    public function JanitorSoundChannel( $target :Object )
    {
      _target = $target;
    }

    /**
     * @return  The string equivalent of this class.
     */
    public function toString() :String
    {
      return 'com.factorylabs.orange.core.gc.JanitorSoundChannel';
    }

    /**
     * @inheritDoc
     */
    public function cleanUp() :void
    {
      cleanUpSoundChannels();
    }

    /**
     * Adds a <code>SoundChannel</code> to it's <code>Dictionary</code>.
     * @param $soundChannel the channel to add.
     */
    public function addSoundChannel( $soundChannel :SoundChannel ) :void
    {
      if( !_soundChannels ) _soundChannels = new Dictionary( true );
      _soundChannels[ $soundChannel ] = true;
    }

    /**
     * Removes a <code>SoundChannel</code> from it's <code>Dictionary</code>.
     * @param $soundChannel the channel to remove.
     */
    public function removeSoundChannel( $soundChannel :SoundChannel ) :void
    {
      if( !_soundChannels ) return;
      delete( _soundChannels[ $soundChannel ] );
    }

    /**
     * Cleans up all <code>SoundChannel</code>s in it's <code>Dictionary</code> by calling stop and removing them.
     */
    public function cleanUpSoundChannels() :void
    {
      for( var soundChannel :Object in _soundChannels )
      {
        var sc :SoundChannel = SoundChannel( soundChannel );
        sc.stop();
        removeSoundChannel( sc );
      }
    }
  }
}


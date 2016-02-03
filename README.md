# Evil-Music-Player

##Installing Evil Music Player
  Evil Music Player is for iOS only, and can be installed by creating a project in xcode and adding all of the files in this rep.
  
##Objects
  There are two objects worth noting: the EVLMusicManager and EVLMusic.  The EVLMusic class can be used on it's own, but is not in this project.
  Instead, given there is are sound files included in the bundle, the EVLMusicManager is used to manage a list of EVLMusic created from these files.
  EVLMusicManager can very easily be edited to create a playlist from any provided source of sound files.
  EVLMusicManager will automatically use any .mp3, .wav, or .aiff files you add to the bundle without the need for editing.
  
##EVLMusic

```
+ (id) musicNamed:(NSString *)name;
```
Returns an instance of EVLMusic if any .mp3, .wav, or .aiff file can be found with the provided name in the bundle.

```
+ (id) musicWithContentsOfFile:(NSString *)path;
- (id) initWithContentsOfFile:(NSString *)path;
+ (id) musicWithContentsOfURL:(NSURL *)URL;
- (id) initWithContentsOfURL:(NSURL *)URL;
```
Returns an instance of EVLMusic if a sound file can be found at the supplied path/URL.

```
@property (nonatomic) NSString *name;
```
The name of the original file (without the included extension).  This is to be used for display when playing the file.

```
@property (nonatomic) NSURL *URL;
```
The url to the original file's location.

```
@property (nonatomic, getter = isPlaying) BOOL playing;
```
Returns true if the music file is playing, false if the music has finished or has been paused.

```
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) NSTimeInterval currentTime;
```
The total length of the music file and the current play time of the music file (if being played), respectively.

```
- (void) play;
- (void) stop;
```
Plays or stops the AVAudioPlayer playing the audio file.

```
- (void) setVolume:(float)volume;
```
Sets the volume of the AVAudioPlayer playing the audio file.

##EVLMusicManager

```
@property (nonatomic, getter = isPlayingMusic) BOOL playingMusic;
```
Returns the "playing" property of the currently selected EVLMusic object.

```
@property (nonatomic) float volume;
```
Sets the volume for all EVLMusic objects in the playlist.

```
+ (EVLMusicManager *) sharedInstance;
```
Returns a singleton of the EVLMusicManager.

```
- (void) playMusic:(EVLMusic *)music;
```
Plays the supplied EVLMusic object.

```
- (void) stopMusic;
```
Stops any and all music currently being played

```
- (void) loadDefaultPlaylist;
```
Searches the bundle for any .mp3, .wav, and .aiff files and creates a playlist of EVLMusic objects from those files.

```
- (void) playCurrentTrack
```
Plays the currently loaded EVLMusic object.  Loads the default playist if the playlist is empty.  Selects the first EVLMusic object if none have been selected.

```
- (void) playNextTrack;
- (void) playPreviousTrack;
```
Plays the next (or previous) EVLMusic object in the playlist.  Loops to first (or last) object when it reaches the end (or beginning).

```
- (NSString *) getTrackName;
```
Returns the name of the currently selected ELVMusic object.

```
- (NSTimeInterval) getTrackLength;
```
Returns the total length of the currently selected EVLMusic object. 

```
- (NSTimeInterval) getCurrentTrackTime;
```
Returns the current play time of the currently selected EVLMusic object.

```
- (void) setCurrentTrackTime:(NSTimeInterval)time;
```
Seeks the currently selected EVLMusic object to the supplied time.

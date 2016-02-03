//
//  EVLMusicManager.h
//  Evil Music Player
//
//  Created by Joseph Manis on 1/28/16.
//  Copyright © 2016 Joseph Manis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EVLMusic;

@interface EVLMusicManager : NSObject

@property (nonatomic, getter = isPlayingMusic) BOOL playingMusic;
@property (nonatomic) float volume;

+ (EVLMusicManager *) sharedInstance;
- (void) playMusic:(EVLMusic *)music;
- (void) stopMusic;
- (void) loadDefaultPlaylist;
- (void) playCurrentTrack;
- (void) playNextTrack;
- (void) playPreviousTrack;

- (NSString *) getTrackName;
- (NSTimeInterval) getTrackLength;
- (NSTimeInterval) getCurrentTrackTime;
- (void) setCurrentTrackTime:(NSTimeInterval)time;

@end

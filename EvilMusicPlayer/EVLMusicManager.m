//
//  EVLMusicManager.m
//  Evil Music Player
//
//  Created by Joseph Manis on 1/28/16.
//  Copyright © 2016 Joseph Manis. All rights reserved.
//

#import "EVLMusicManager.h"
#import "EVLMusic.h"

@interface EVLMusicManager()

@property (nonatomic) EVLMusic *currentMusic;
@property (nonatomic) NSMutableArray *allMusic;

@end

@implementation EVLMusicManager

static EVLMusicManager *sharedInstance = nil;

+ (EVLMusicManager *) sharedInstance {
    
    if (sharedInstance == nil) {
        sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
    
}

- (id) init {
    
    if ((self = [super init])) {
        
        _volume = 1.0f;
        [self loadDefaultPlaylist];
        
    }
    
    return self;
    
}

- (void) loadDefaultPlaylist {
    
    _currentMusic = nil;
    _allMusic = [[NSMutableArray alloc] init];
    NSArray *fileTypes = @[@"wav", @"mp3", @"aiff"];
    NSArray *paths;
    for (NSString *type in fileTypes) {
        
        paths = [[NSBundle mainBundle] pathsForResourcesOfType:type inDirectory:nil];
        for (NSString *path in paths) {
            [_allMusic addObject:[EVLMusic musicWithContentsOfFile:path]];
        }
        
    }
    
}

- (void) playCurrentTrack {
    
    if (_allMusic == nil || _allMusic.count == 0) {
        [self loadDefaultPlaylist];
    }
    
    if (_currentMusic == nil) {
        _currentMusic = _allMusic.firstObject;
    }
    
    [self playMusic:_currentMusic];
    
}

- (void) playNextTrack {
    
    if (_currentMusic != nil) {
        [_currentMusic stop];
    }
    
    if (_allMusic == nil || _allMusic.count == 0) {
        [self loadDefaultPlaylist];
    }
    
    if (_currentMusic == _allMusic.lastObject) {
        [self playMusic:_allMusic.firstObject];
    } else {
        long index = [_allMusic indexOfObject:_currentMusic];
        if (index + 1 < _allMusic.count) {
            [self playMusic:_allMusic[index + 1]];
        } else {
            [self playMusic:_allMusic.firstObject];
        }
    }
    
}

- (void) playPreviousTrack {
    
    if (_currentMusic != nil) {
        [_currentMusic stop];
    }
    
    if (_allMusic == nil || _allMusic.count == 0) {
        [self loadDefaultPlaylist];
    }
    
    if (_currentMusic == _allMusic.firstObject) {
        [self playMusic:_allMusic.lastObject];
    } else {
        long index = [_allMusic indexOfObject:_currentMusic];
        if (index < _allMusic.count) {
            [self playMusic:_allMusic[index - 1]];
        } else {
            [self playMusic:_allMusic.firstObject];
        }
    }
    
}

- (void) playMusic:(EVLMusic *)music {
        
    self.currentMusic = music;
    [_currentMusic setVolume:_volume];
    [_currentMusic play];
    _currentMusic.playing = YES;
    
}

- (void) stopMusic {
    [_currentMusic stop];
    _currentMusic.playing = NO;
}

- (BOOL) isPlayingMusic {
    return _currentMusic.isPlaying;
}

- (void) setVolume:(float)newVolume {
    _volume = newVolume;
    [_currentMusic setVolume:newVolume];
}

- (NSString *) getTrackName {
    return _currentMusic.name;
}

- (NSTimeInterval) getTrackLength {
    return _currentMusic.duration;
}

- (NSTimeInterval) getCurrentTrackTime {
    return _currentMusic.currentTime;
}

- (void) setCurrentTrackTime:(NSTimeInterval)time {
    [_currentMusic setCurrentTime:time];
    if (!_currentMusic.playing) {
        _currentMusic.playing = YES;
        [_currentMusic play];
    }
}

@end

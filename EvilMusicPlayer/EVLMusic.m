//
//  EVLMusic.m
//  Evil Music Player
//
//  Created by Joseph Manis on 1/28/16.
//  Copyright © 2016 Joseph Manis. All rights reserved.
//

#import "EVLMusic.h"

@interface EVLMusic() <AVAudioPlayerDelegate>

@property (nonatomic) EVLMusic *selfRef;
@property (nonatomic) AVAudioPlayer *player;

@end

@implementation EVLMusic

+ (id) musicNamed:(NSString *)name {
    
    NSString *path;
    if (![name isAbsolutePath]) {
        
        if ([[name pathExtension] isEqualToString:@""]) {
            
            if ((path = [[NSBundle mainBundle] pathForResource:name ofType:@"mp3"]) != nil) {
                return [self musicWithContentsOfFile:path];
            } else if ((path = [[NSBundle mainBundle] pathForResource:name ofType:@"wav"]) != nil) {
                return [self musicWithContentsOfFile:path];
            } else if ((path = [[NSBundle mainBundle] pathForResource:name ofType:@"aiff"]) != nil) {
                return [self musicWithContentsOfFile:path];
            }
            
        }
        
    }
    
    return nil;
    
}

+ (id) musicWithContentsOfFile:(NSString *)path {
    return [[self alloc] initWithContentsOfFile:path];
}

+ (id) musicWithContentsOfURL:(NSURL *)URL {
    return [[self alloc] initWithContentsOfURL:URL];
}

- (id) initWithContentsOfFile:(NSString *)path {
    return [self initWithContentsOfURL:path ? [NSURL fileURLWithPath:path] : nil];
}

- (id) initWithContentsOfURL:(NSURL *)URL {
    
    if ((self = [super init])) {
        _URL = URL;
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:URL error:nil];
    }
    
    return self;
    
}

- (void) prepareToPlay {
    [AVAudioSession sharedInstance];
    [_player prepareToPlay];
    
}

- (NSString *) name {
    return [[[_URL path] lastPathComponent] stringByDeletingPathExtension];
}

- (NSTimeInterval) duration {
    return [_player duration];
}

- (NSTimeInterval) currentTime {
    return [_player currentTime];
}

- (void) setCurrentTime:(NSTimeInterval)currentTime {
    [_player setCurrentTime:currentTime];
}

- (BOOL) isPlaying {
    return [_player isPlaying];
}

- (void) play {
    if (!self.playing) {
        self.selfRef = self;
        [_player setDelegate:self];
        [_player play];
    }
}

- (void) stop {
    
    if (self.playing) {
        
        [_player stop];
        
    }
    
}

- (void) setVolume:(float)volume {
    _player.volume = volume;
}

@end

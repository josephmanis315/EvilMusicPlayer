//
//  EVLMusic.h
//  Evil Music Player
//
//  Created by Joseph Manis on 1/28/16.
//  Copyright © 2016 Joseph Manis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface EVLMusic : NSObject

+ (id) musicNamed:(NSString *)name;
+ (id) musicWithContentsOfFile:(NSString *)path;
- (id) initWithContentsOfFile:(NSString *)path;
+ (id) musicWithContentsOfURL:(NSURL *)URL;
- (id) initWithContentsOfURL:(NSURL *)URL;

@property (nonatomic) NSString *name;
@property (nonatomic) NSURL *URL;
@property (nonatomic, getter = isPlaying) BOOL playing;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) NSTimeInterval currentTime;

- (void) prepareToPlay;
- (void) play;
- (void) stop;
- (void) setVolume:(float)volume;

@end

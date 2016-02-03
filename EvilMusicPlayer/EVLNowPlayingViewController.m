//
//  EVLNowPlayingViewController.m
//  Evil Music Player
//
//  Created by Joseph Manis on 1/28/16.
//  Copyright © 2016 Joseph Manis. All rights reserved.
//

#import "EVLNowPlayingViewController.h"
#import "EVLMusicManager.h"

static BOOL noteAnimated = NO;

@interface EVLNowPlayingViewController ()

@end

@implementation EVLNowPlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)volumeChanged:(id)sender {
    [[EVLMusicManager sharedInstance] setVolume:_volumeSlider.value];
}

- (IBAction)playPauseButtonPressed:(id)sender {
    
    if ([EVLMusicManager sharedInstance].isPlayingMusic) {
        [[EVLMusicManager sharedInstance] stopMusic];
        [_playPauseButton setImage:nil forState:UIControlStateNormal];
        [_playPauseButton setImage:[UIImage imageNamed:@"Play"] forState:UIControlStateNormal];
    } else {
        [[EVLMusicManager sharedInstance] playCurrentTrack];
        [_playPauseButton setImage:nil forState:UIControlStateNormal];
        [_playPauseButton setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateNormal];
    }
    
    [self presentSong];
    
}

- (IBAction)previousButtonPressed:(id)sender {
    [[EVLMusicManager sharedInstance] playPreviousTrack];
    [_playPauseButton setImage:nil forState:UIControlStateNormal];
    [_playPauseButton setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateNormal];
    [self presentSong];
}

- (IBAction)nextButtonPressed:(id)sender {
    [[EVLMusicManager sharedInstance] playNextTrack];
    [_playPauseButton setImage:nil forState:UIControlStateNormal];
    [_playPauseButton setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateNormal];
    [self presentSong];
}

- (IBAction)scanValueChanged:(id)sender {
    [self invalidateMusicTimer];
    [self updateCurrentTimeLabelWithTime:[[EVLMusicManager sharedInstance] getTrackLength] * ((UISlider *) sender).value];
}

- (IBAction)scanReleased:(id)sender {
    [[EVLMusicManager sharedInstance] setCurrentTrackTime:[[EVLMusicManager sharedInstance] getTrackLength] * ((UISlider *) sender).value];
    [self presentSong];
}

- (void) presentSong {
    
    [self invalidateMusicTimer];
    if ([EVLMusicManager sharedInstance].isPlayingMusic) {
    
        [self wobbleNoteRight];
        _songTitleLabel.text = [[EVLMusicManager sharedInstance] getTrackName];
        [self updateSongProgress];
        dispatch_async(dispatch_get_main_queue(), ^{
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateSongProgress) userInfo:nil repeats:YES];
        });
        
    }
    
}

- (void) updateSongProgress {
    
    _songProgressSlider.value = [[EVLMusicManager sharedInstance] getCurrentTrackTime] / [[EVLMusicManager sharedInstance] getTrackLength];
    [self updateCurrentTimeLabel];
    [self updateEndTimeLabel];
    if (![EVLMusicManager sharedInstance].isPlayingMusic) {
        [_playPauseButton setImage:nil forState:UIControlStateNormal];
        [_playPauseButton setImage:[UIImage imageNamed:@"Play"] forState:UIControlStateNormal];
        _songProgressSlider.value = 0.0;
        [self invalidateMusicTimer];
    } else {
        
        if (![UIImagePNGRepresentation(_playPauseButton.imageView.image) isEqual:UIImagePNGRepresentation   ([UIImage imageNamed:@"Pause"])]){
            [_playPauseButton setImage:nil forState:UIControlStateNormal];
            [_playPauseButton setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateNormal];
        }
    }
    
}

- (void) wobbleNoteRight {
    
    if (!noteAnimated) {
        
        noteAnimated = YES;
        CGAffineTransform rightWobble = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI / 8);
        [UIImageView animateWithDuration:0.50 delay:0 options:0 animations:^{
            _noteImageView.transform = rightWobble;
        }completion:^(BOOL finished){
            [self wobbleNoteLeft];
        }];
        
    }
    
}

- (void) wobbleNoteLeft {
    
    CGAffineTransform leftWobble = CGAffineTransformRotate(CGAffineTransformIdentity, 0);
    [UIImageView animateWithDuration:0.50 delay:0 options:0 animations:^{
        _noteImageView.transform = leftWobble;
    }completion:^(BOOL finished){
        
        noteAnimated = NO;
        if ([EVLMusicManager sharedInstance].isPlayingMusic) {
            [self wobbleNoteRight];
        }
        
    }];
    
}

- (void) updateCurrentTimeLabelWithTime:(NSTimeInterval)time {
    
    NSInteger currentTrackTime = time;
    int currentSec = currentTrackTime % 60;
    int currentMin = (currentTrackTime / 60) % 60;
    _currentTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d", currentMin, currentSec];
    
}

- (void) updateCurrentTimeLabel {
    NSInteger currentTrackTime = [[EVLMusicManager sharedInstance] getCurrentTrackTime];
    int currentSec = currentTrackTime % 60;
    int currentMin = (currentTrackTime / 60) % 60;
    _currentTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d", currentMin, currentSec];
}

- (void) updateEndTimeLabel {
    NSInteger endTime = [[EVLMusicManager sharedInstance] getTrackLength];
    int endSec = endTime % 60;
    int endMin = (endTime / 60) % 60;
    _endTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d", endMin, endSec];
}

- (void) invalidateMusicTimer {
    
    if (_timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
    
}

@end

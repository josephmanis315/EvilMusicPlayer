//
//  EVLNowPlayingViewController.h
//  Evil Music Player
//
//  Created by Joseph Manis on 1/28/16.
//  Copyright © 2016 Joseph Manis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVFoundation/AVFoundation.h"

@interface EVLNowPlayingViewController : UIViewController

@property (nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIImageView *noteImageView;
@property (weak, nonatomic) IBOutlet UILabel *songTitleLabel;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UISlider *songProgressSlider;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;

- (IBAction)volumeChanged:(id)sender;
- (IBAction)playPauseButtonPressed:(id)sender;
- (IBAction)previousButtonPressed:(id)sender;
- (IBAction)nextButtonPressed:(id)sender;
- (IBAction)scanValueChanged:(id)sender;
- (IBAction)scanReleased:(id)sender;

@end

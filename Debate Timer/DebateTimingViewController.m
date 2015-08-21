//
//  DebateTimingViewController.m
//  Debate Timer
//
//  Created by Chen Zhibo on 8/20/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "DebateTimingViewController.h"
#import "DebateSession.h"
#import "DebateSessionReminder.h"
#import "DebateSessionPlayer.h"
@import AVFoundation;


@interface DebateTimingViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelTiming;
@property (weak, nonatomic) IBOutlet UILabel *labelElapsedTime;
@property (weak, nonatomic) IBOutlet UILabel *labelTotoalTime;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UIButton *buttonEdit;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (strong, nonatomic) DebateSessionPlayer *player, *testerPlayer;
@property (strong, nonatomic) DebateSession *session;
@property (nonatomic) int selectedTimingSessionNumber;
@property (weak, nonatomic) IBOutlet UIButton *testingSoundButton;

@end

@implementation DebateTimingViewController

- (IBAction)testSounding:(id)sender {
    self.testingSoundButton.enabled = NO;
    DebateSession *session = [[DebateSession alloc] init];
    
    session.length = 1;
    [session.reminds addObject:[[DebateSessionReminder alloc] initWithBeepTimes:1 timePoint:0.5]];
    self.testerPlayer = [[DebateSessionPlayer alloc] initWithDebateSession:session];
    [self.testerPlayer playWithUpdateBlock:^(NSTimeInterval currentTime) {
        if (currentTime > 1) {
            [self.testerPlayer stop];
            self.testerPlayer = nil;
            self.testingSoundButton.enabled = YES;
        }
    }];
}



- (IBAction)start:(id)sender {
    self.buttonEdit.enabled = NO;
    self.startButton.enabled = NO;
    self.stopButton.enabled = YES;
    self.player = [[DebateSessionPlayer alloc] initWithDebateSession:self.session];
    [self.player playWithUpdateBlock:^(NSTimeInterval currentTime) {
        self.labelTiming.text = [self stringForFormattedTimeInterval:self.session.length - currentTime];
        self.labelElapsedTime.text = [self stringForFormattedTimeInterval:currentTime];
        self.progressBar.progress = currentTime / self.session.length;
        
        
        //coloring
        double remainingTime = self.session.length - currentTime;
        if (remainingTime < 30) {
            if (remainingTime < 0) {
                self.labelTiming.textColor = [UIColor colorWithRed:179 green:0 blue:0 alpha:1.0];
            } else {
                self.labelTiming.textColor = [UIColor colorWithRed:255/255 green:222/255 blue:132/255 alpha:1.0];
            }
        }  else {
            self.labelTiming.textColor = [UIColor blackColor];
        }
        //         < 30?( self.session.length - currentTime < 0? ::[UIColor blackColor];
    }];
    
    [UIApplication sharedApplication].idleTimerDisabled = YES;
}
- (IBAction)stop:(id)sender {
    
    if (self.startButton.enabled == YES) {
        self.stopButton.enabled = NO;
        self.labelTiming.textColor = [UIColor blackColor];
        [UIApplication sharedApplication].idleTimerDisabled = NO;
        self.selectedTimingSessionNumber = self.selectedTimingSessionNumber;
    } else {
        [self.player stop];
        self.buttonEdit.enabled = YES;
        self.startButton.enabled = YES;
    }
    
}
- (IBAction)edit:(id)sender {
    
    if (self.selectedTimingSessionNumber == 0) {
        self.selectedTimingSessionNumber = 1;
    } else {
        self.selectedTimingSessionNumber = 0;
    }
}
//YELLOW 255 222 132
//RED 179 0 0
- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    self.selectedTimingSessionNumber = 2;
    self.stopButton.enabled = NO;
    NSError *error;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDuckOthers error:&error];
    [[[UIAlertView alloc] initWithTitle:@"Reminder" message:@"During timer countdown, your device is disabled from sleeping. Please make sure that silence mode is turned off and volumn is turned up. Timer may not function properly while running in the background." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    
}

- (void)setSelectedTimingSessionNumber:(int)selectedTimingSessionNumber
{
    _selectedTimingSessionNumber = selectedTimingSessionNumber;
    self.session = [self debateSessionWithType:selectedTimingSessionNumber];

}

- (void)setSession:(DebateSession *)session
{
    _session = session;
    [self updateUI];
}

- (void)updateUI
{
    self.labelTiming.text = [self stringForFormattedTimeInterval:self.session.length];
    self.labelElapsedTime.text = [self stringForFormattedTimeInterval:0];
    self.labelTotoalTime.text = [self stringForFormattedTimeInterval:self.session.length];
    self.progressBar.progress = 0;
   [self.buttonEdit setTitle:self.selectedTimingSessionNumber==0?@"Change to 8:00":@"Change to 4:00" forState:UIControlStateNormal];
    
}

- (NSString *)stringForFormattedTimeInterval:(NSTimeInterval)timeInterval
{
    if (timeInterval < 0) {
        return [NSString stringWithFormat:@"%d", (int)timeInterval];
    }
    int numOfMinutes = (int)(timeInterval/60);
    int numOfSeconds = ((int)ceil(timeInterval)) % 60;
    return [NSString stringWithFormat:@"%@%d:%@%d", numOfMinutes<10?@"0":@"", numOfMinutes, numOfSeconds<10?@"0":@"", numOfSeconds];
}

- (DebateSession *)debateSessionWithType:(int)type
{
    DebateSession *session = [[DebateSession alloc] init];
    int length = 0;
    switch (type) {
        case 0:
            length = 4 * 60 + 30;
            session.length = length;
            [session.reminds addObject:[[DebateSessionReminder alloc] initWithBeepTimes:1 timePoint:60 * 3]];
            [session.reminds addObject:[[DebateSessionReminder alloc] initWithBeepTimes:2 timePoint:60 * 4]];
            [session.reminds addObject:[[DebateSessionReminder alloc] initWithBeepTimes:3 timePoint:60 * 4 + 20]];
            [session.reminds addObject:[[DebateSessionReminder alloc] initWithBeepTimes:0 timePoint:60 * 4 + 30]];
            break;
        case 1:
            length = 8 * 60 + 30;
            session.length = length;
            [session.reminds addObject:[[DebateSessionReminder alloc] initWithBeepTimes:1 timePoint:60]];
            [session.reminds addObject:[[DebateSessionReminder alloc] initWithBeepTimes:1 timePoint:60 * 7]];
            [session.reminds addObject:[[DebateSessionReminder alloc] initWithBeepTimes:2 timePoint:60 * 8]];
            [session.reminds addObject:[[DebateSessionReminder alloc] initWithBeepTimes:3 timePoint:60 * 8 + 20]];
            [session.reminds addObject:[[DebateSessionReminder alloc] initWithBeepTimes:0 timePoint:60 * 8 + 30]];
            break;
        case 2:
            length = 10;
            session.length = length;
            [session.reminds addObject:[[DebateSessionReminder alloc] initWithBeepTimes:1 timePoint:3]];
            [session.reminds addObject:[[DebateSessionReminder alloc] initWithBeepTimes:2 timePoint:5]];
//            [session.reminds addObject:[[DebateSessionReminder alloc] initWithBeepTimes:3 timePoint:7]];
//            [session.reminds addObject:[[DebateSessionReminder alloc] initWithBeepTimes:0 timePoint:10]];
            
            break;
        default:
            break;
    }
    return session;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

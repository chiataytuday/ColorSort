//
//  VerticalProgressBar.m
//  ColorTest
//
//  Created by Frankie Laguna on 4/5/12.
//  Copyright (c) 2012 Frankie Laguna. All rights reserved.
//

#import "VerticalProgressBar.h"

//Frameworks
#import <QuartzCore/QuartzCore.h>

//Other
#import "Notifications.h"

//Static config
#define MARGIN 1.0f
#define BACKGROUND_WIDTH 3.0f
#define INTERVAL 0.01f
#define MESSAGE_MARGIN 10.0f
#define MESSAGE_WIDTH 150.0f
#define MESSAGE_HEIGHT 50.0f
#define FONT_SIZE 32.0f

@interface VerticalProgressBar()
@property(strong, nonatomic) UIView *backgroundView;
@property(strong, nonatomic) UIView *progressView;
@property(strong, nonatomic) UIView *messageView;
@property(strong, nonatomic) UILabel *timeLabel;

@property(strong, nonatomic) NSTimer *timer;

-(void)stopTimer;
-(void)countdown;
-(void)updateUI;
-(void)updateLabel;
@end

@implementation VerticalProgressBar
@synthesize totalSeconds = _totalSeconds, secondsLeft;
@synthesize backgroundView, progressView, messageView, timeLabel;
@synthesize timer;

-(id)initWithFrame:(CGRect)frame{
  if(self = [super initWithFrame:frame]){    
    //Configure background view
    CGRect backgroundFrame = CGRectMake(MARGIN, MARGIN, BACKGROUND_WIDTH, CGRectGetHeight(frame)-MARGIN*2);
    self.backgroundView = [[UIView alloc] initWithFrame:backgroundFrame];
    [self.backgroundView setBackgroundColor:[UIColor blackColor]];
    
    //Configure progress view
    CGRect progressFrame = CGRectMake(MARGIN, MARGIN, 1.0f, CGRectGetHeight(backgroundFrame)-MARGIN*2);
    self.progressView = [[UIView alloc] initWithFrame:progressFrame];
    [self.progressView setBackgroundColor:[UIColor whiteColor]];
    
    //Create the message view that will be display the seconds it took when the timer is paused/finished
    CGRect messageFrame = CGRectMake(CGRectGetMaxX(backgroundFrame) + MESSAGE_MARGIN, 0, MESSAGE_WIDTH, MESSAGE_HEIGHT);
    self.messageView = [[UIView alloc] initWithFrame:messageFrame];
    [self.messageView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.7f]];
    [self.messageView.layer setCornerRadius:5.0f];
    [self.messageView setAlpha:0.0f];
    
    //Create the label itself
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MESSAGE_WIDTH, MESSAGE_HEIGHT)];
    [self.timeLabel setBackgroundColor:[UIColor clearColor]];
    [self.timeLabel setTextColor:[UIColor whiteColor]];
    [self.timeLabel setTextAlignment:UITextAlignmentCenter];
    [self.timeLabel setFont:[UIFont systemFontOfSize:FONT_SIZE]];
    
    
    [self.backgroundView addSubview:self.progressView];
    [self addSubview:self.backgroundView];
    
    [self.messageView addSubview:self.timeLabel];
    [self addSubview:self.messageView];
  }

  return self;
}

#pragma mark - Setters
-(void)setTotalSeconds:(NSUInteger)totalSeconds{
  _totalSeconds = totalSeconds;
  
  [self setSecondsLeft:totalSeconds];
}

#pragma mark - Public
-(void)startTimer{
  self.timer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL target:self selector:@selector(countdown) userInfo:nil repeats:YES];
}

-(void)pauseTimer{
  [self stopTimer];
  
  [self updateLabel];
}

-(void)reset{
  self.secondsLeft = self.totalSeconds;
  
  [self updateUI];
  
  [UIView animateWithDuration:0.1f animations:^{
    [self.messageView setAlpha:0.0f];
  }];
}

#pragma mark - Private
-(void)countdown{
  self.secondsLeft -= INTERVAL;
  
  if(self.secondsLeft < 0.0f){
    self.secondsLeft = 0.0f;
    
    //Finished
    [self stopTimer];
    
    //Alert the listening views that it's over!
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TIMER_COMPLETE object:nil];
  }
  
  [self updateUI];
}

-(void)updateUI{  
  CGFloat percentLeft = (self.secondsLeft / (CGFloat)self.totalSeconds);

  CGFloat backgroundHeight = CGRectGetHeight(self.backgroundView.frame) - (MARGIN * 2);
  CGFloat height = round(backgroundHeight * percentLeft);
  CGFloat y = (backgroundHeight - height) + MARGIN;
  
  [UIView animateWithDuration:INTERVAL animations:^{
    CGRect frame = self.progressView.frame;
    frame.size.height = height;
    frame.origin.y = y;
    
    [self.progressView setFrame:frame];
  }];
}

-(void)updateLabel{  
  if(!self.messageView.alpha){    
    [UIView animateWithDuration:0.1f animations:^{
      [self.messageView setAlpha:1.0f];
    }];
  }
  
  CGFloat timeTaken = (self.totalSeconds - self.secondsLeft);
  
  CGFloat minutes = fmodf((timeTaken / 60.0f), 60.0f);
  CGFloat seconds = fmodf(timeTaken, 60.0f);  
  CGFloat hundredths = (timeTaken - floor(timeTaken)) * 100;
  
  NSString *timeString = [NSString stringWithFormat:@"%02.0f:%02.0f:%02.0f", minutes, seconds, hundredths];
  
  [self.timeLabel setText:timeString];
  
  CGRect labelFrame = self.messageView.frame;
  
  CGFloat percentLeft = (self.secondsLeft / (CGFloat)self.totalSeconds);
  CGFloat backgroundHeight = CGRectGetHeight(self.backgroundView.frame) - (MARGIN * 2);
  CGFloat progressHeight = round(backgroundHeight * percentLeft);
  
  CGFloat y = (backgroundHeight - progressHeight) - (labelFrame.size.height / 2);
  
  if(y + MESSAGE_HEIGHT > CGRectGetHeight(self.frame)){
    y = CGRectGetHeight(self.frame) - MESSAGE_HEIGHT - MESSAGE_MARGIN;
  }
  else if(y - MESSAGE_HEIGHT < 0.0f){
    y = MESSAGE_MARGIN;
  }
  
  labelFrame.origin.y = y;
  
  [self.messageView setFrame:labelFrame];
}

-(void)stopTimer{
  [self.timer invalidate];
  self.timer = nil;
}

@end

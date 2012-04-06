//
//  ViewController.m
//  ColorTest
//
//  Created by Frankie Laguna on 4/4/12.
//  Copyright (c) 2012 Frankie Laguna. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ViewController.h"

#import "Notifications.h"

//Helpers
#import "NSMutableArray+ArchUtils_Shuffle.h"
#import "ColorSpaceUtilities.h"
#import "UIColor+Utilities.h"

//Custom Views
#import "SegmentView.h"
#import "VerticalProgressBar.h"
#import "FailedView.h"
#import "SuccessView.h"

#define FLASH_DURATION 0.1f

//Enums
typedef enum{
  RGB_RED = 0,
  RGB_GREEN = 1,
  RGB_BLUE = 2
} RGB;

@interface ViewController ()
@property(strong, nonatomic) NSMutableArray *segments;
@property(strong, nonatomic) UIView *flashView;

@property(strong, nonatomic) VerticalProgressBar *timerView;

@property(strong, nonatomic) FailedView *failedView;
@property(strong, nonatomic) SuccessView *successView;

@property(nonatomic) NSUInteger minSegments;
@property(nonatomic) NSUInteger maxSegments;

@property(nonatomic) NSUInteger totalSegments;

@property(nonatomic) CGFloat segmentHeight;

@property(nonatomic) BOOL canDrag;
@property(nonatomic) BOOL isDragging;
@property(strong, nonatomic) SegmentView *draggingView;
@property(nonatomic) CGPoint startPoint;

@property(strong, nonatomic) UIColor *startColor;
@property(strong, nonatomic) UIColor *endColor;
@property(strong, nonatomic) UIColor *currentColor;

-(void)newGame;
-(void)newGame:(BOOL)isReplay;

-(void)clearGame;

-(void)shiftViews:(NSInteger)hoverIndex;
-(void)snapDragView;

-(BOOL)didWin;
-(void)timerCompleted;

-(void)showSuccessView;

//Color utilities
-(UIColor *)colorForIndex:(NSUInteger)index;

-(void)image:(UIImage *)image didFinishedSaving:(NSError *)error contextInfo:(void *)context;
@end

@implementation ViewController
@synthesize segments;
@synthesize totalSegments, minSegments, maxSegments;
@synthesize timerView, failedView, successView;
@synthesize flashView;

@synthesize canDrag;
@synthesize isDragging, draggingView, startPoint;
@synthesize segmentHeight;
@synthesize startColor, endColor, currentColor;

#pragma mark - View Life Cycle
-(void)viewDidLoad{
  [super viewDidLoad];
  
  [[UIApplication sharedApplication] setStatusBarHidden:YES];
  
  [self.view setFrame:[[UIScreen mainScreen] bounds]];
  [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
  
  //Configure
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timerCompleted) name:NOTIFICATION_TIMER_COMPLETE object:nil];
  
  self.maxSegments = 8;
  self.minSegments = 5;
  
  //Setup the failed view
  CGRect failedFrame = CGRectMake(0, 0, 200.0f, 72.0f);
  failedFrame.origin.y = (CGRectGetMidY(self.view.frame) * 0.75f)- CGRectGetMidY(failedFrame);
  failedFrame.origin.x = CGRectGetMidX(self.view.frame) - CGRectGetMidX(failedFrame);
  self.failedView = [[FailedView alloc] initWithFrame:failedFrame];
  [self.failedView setAlpha:0.0f];
  [self.failedView setDelegate:self];
  
  //Setup the success view
  CGRect successFrame = CGRectMake(0, 0, 63.0f, 326.0f);
  successFrame.origin.y = CGRectGetMidY(self.view.frame)- CGRectGetMidY(successFrame);
  successFrame.origin.x = CGRectGetMaxX(self.view.frame) - (CGRectGetWidth(successFrame)-3);
  self.successView = [[SuccessView alloc] initWithFrame:successFrame];
  [self.successView setAlpha:0.0f];
  [self.successView setDelegate:self];
  
  //Setup the timer
  self.timerView = [[VerticalProgressBar alloc] initWithFrame:CGRectMake(0, 0, 20, CGRectGetHeight(self.view.frame))];
  [self.timerView setTotalSeconds:10];
  
  [self.view addSubview:self.timerView];
  
  [self newGame];
}

-(void)viewDidUnload{
  [super viewDidUnload];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  
  self.segments = nil;
  self.timerView = nil;
  self.failedView = nil;
  self.successView = nil;
  self.flashView = nil;
  self.startColor = nil;
  self.endColor = nil;
  self.currentColor = nil;
  self.draggingView = nil;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
  return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

//TODO: Convert touches to UIGesture's
#pragma mark - Touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
  UITouch *touch = [touches anyObject];
  
  if(!self.canDrag || !touch.view || ![touch.view isKindOfClass:[SegmentView class]]){    
    return; 
  }
  
  self.isDragging = YES;
  
  self.startPoint = [touch locationInView:touch.view];
  self.draggingView = (SegmentView *)touch.view;
  
  [self.view bringSubviewToFront:self.draggingView];
  [self.view bringSubviewToFront:self.timerView];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
  if(!self.isDragging){ return; }
  
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self.view];
  
  //Get the index of the item we're moving over.
  NSInteger hoverIndex = ((location.y + (self.segmentHeight / 1.5f)) / (self.segmentHeight)) - 1;
  
  if(hoverIndex < 0){ hoverIndex = 0; }
  if(hoverIndex > self.totalSegments-1){ hoverIndex = self.totalSegments-1; }
    
  //Update the array and the segment view's positions
  [self shiftViews:hoverIndex];
  
  //Normalize the Y position so the view doesn't jump 
  CGFloat y = location.y - self.startPoint.y;
  
  CGRect frame = self.draggingView.frame;
  frame.origin.y = y;
  
  [self.draggingView setFrame:frame];  
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
  if(!self.draggingView || !self.canDrag){ return; }
  
  [self snapDragView];

  //Check to see if they won
  if([self didWin]){
    [self setCanDrag:NO];
    
    [self.timerView pauseTimer];
    
    [self showSuccessView];
  }
  
  //Reset
  self.isDragging = NO;
  self.startPoint = CGPointZero;
  self.draggingView = nil;
}

#pragma mark - FailedButtonDelegate, SuccessButtonDelegate
-(void)popToLevelSelect{
  NSLog(@"Level select");
}

-(void)popToHome{
  NSLog(@"Pop to home");
}

-(void)replay{  
  [self newGame:YES];
}

#pragma - SuccessButtonDelegate
-(void)nextLevel{
  NSLog(@"Next Level");
}

-(void)takeScreenshot{  
  [UIView animateWithDuration:0.3f animations:^{
    [self.successView setAlpha:0.0f];
  } completion:^(BOOL finished){
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0f);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();  
    
    self.flashView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.flashView setBackgroundColor:[UIColor whiteColor]];
    [self.flashView setAlpha:0.0f];
    
    [self.view addSubview:self.flashView];
    [self.view bringSubviewToFront:self.flashView];
    
    [UIView animateWithDuration:FLASH_DURATION animations:^{
      [self.flashView setAlpha:1.0f];
    } completion:^(BOOL finished){
      UIImageWriteToSavedPhotosAlbum(screenshot, self, @selector(image:didFinishedSaving:contextInfo:), nil);     
    }];   
  }];
}

#pragma mark - Private
-(void)clearGame{
  if(!self.segments || ![self.segments count]){
    return;
  }
  
  for(SegmentView *segment in self.segments){
    [segment removeFromSuperview];
  }
  
  self.segments = nil;
  
  //Clear the overlays
  [self.timerView reset];
  
  [UIView animateWithDuration:0.1f animations:^{
    [self.failedView setAlpha:0.0f];
    [self.successView setAlpha:0.0f];
  } completion:^(BOOL finished){
    [self.failedView removeFromSuperview];
    [self.successView removeFromSuperview];
  }];
}

-(void)newGame:(BOOL)isReplay{
  [self clearGame];

  [self setCanDrag:YES];

  if(!isReplay){
    self.totalSegments = (arc4random() % (self.maxSegments - self.minSegments)) + self.minSegments;
    
    self.startColor = [UIColor randomColor];
    self.endColor = [UIColor slightlyDarkerColor:self.startColor];
  }
  
  self.segments = [NSMutableArray array];
  
  CGFloat height = CGRectGetHeight(self.view.frame);
  CGFloat width = CGRectGetWidth(self.view.frame);
  
  self.segmentHeight = height / (CGFloat) self.totalSegments;
  
  for(NSInteger i = 0; i < self.totalSegments; i++){
    CGRect frame = CGRectMake(0, 0, width, self.segmentHeight);
    
    SegmentView *segmentView = [[SegmentView alloc] initWithFrame:frame];
    [segmentView setIndex:i];
    [segmentView setOrder:i];
    
    [segmentView setBackgroundColor:[self colorForIndex:i]];
    
    [self.segments addObject:segmentView];
  }
  
  while([self didWin] == YES){    
    [self.segments shuffle];
    
    //Add
    NSUInteger index = 0;
    
    for(SegmentView *segmentView in self.segments){
      CGRect frame = segmentView.frame;
      frame.origin.y = segmentHeight * index;
      
      [segmentView setFrame:frame];
      [segmentView setOrder:index];
      
      if(!segmentView.superview){
        [self.view addSubview:segmentView];
      }
      
      index++;
    }
  }
  
  [self.view bringSubviewToFront:self.timerView];
  
  [self.timerView startTimer];
}

-(void)newGame{
  [self newGame:NO];
}

-(void)snapDragView{
  //Snap the view that's being dragged to it's new position
  [UIView animateWithDuration:0.1f animations:^{
    CGRect frame = self.draggingView.frame;
    frame.origin.y = (self.segmentHeight * self.draggingView.order);
    
    [self.draggingView setFrame:frame];
  }];
}

-(void)shiftViews:(NSInteger)hoverIndex{
  NSUInteger draggingIndex = self.draggingView.order;
  
  if(hoverIndex == draggingIndex){ return; }
  
  SegmentView *overView = [self.segments objectAtIndex:hoverIndex];
  
  [UIView animateWithDuration:0.1f animations:^{
    CGRect frame = overView.frame;
    frame.origin.y = (draggingIndex * self.segmentHeight);
    
    [overView setFrame:frame];
  }];
  
  [overView setOrder:draggingIndex];
  [self.draggingView setOrder:hoverIndex];
  
  [self.segments exchangeObjectAtIndex:hoverIndex withObjectAtIndex:draggingIndex];
}

-(UIColor *)colorForIndex:(NSUInteger)index{  
  CGFloat percent = ((CGFloat)index / (CGFloat)(self.totalSegments-1));

  UIColor *startColorRGB = [UIColor toRGB:self.startColor];
  UIColor *endColorRGB = [UIColor toRGB:self.endColor];
  
  const float *startColors = CGColorGetComponents(startColorRGB.CGColor);
  const float *endColors = CGColorGetComponents(endColorRGB.CGColor);
  
  CGFloat red = (endColors[RGB_RED] * percent) + (startColors[RGB_RED] * (1 - percent));
  CGFloat green = endColors[RGB_GREEN] * percent + (startColors[RGB_GREEN] * (1 - percent));
  CGFloat blue = endColors[RGB_BLUE] * percent + (startColors[RGB_BLUE] * (1 - percent));
    
  return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];;
}

-(BOOL)didWin{
  BOOL didWin = YES;
  
  for(SegmentView *segment in self.segments){    
    if(segment.order != segment.index){
      didWin = NO;
      break;
    }
  }
  
  return didWin;
}

-(void)timerCompleted{
  [self snapDragView];
  [self setCanDrag:NO];
  
  [self.view addSubview:self.failedView];
  [self.view bringSubviewToFront:self.failedView];
  
  [UIView animateWithDuration:0.1f animations:^{
    [self.failedView setAlpha:1.0f];
  }];
}


-(void)showSuccessView{
  if(!self.successView.superview){
    [self.view addSubview:self.successView];
    [self.view bringSubviewToFront:self.successView];
  }
  
  [UIView animateWithDuration:0.1f animations:^{
    [self.successView setAlpha:1.0f];
  }];
}

-(void)image:(UIImage *)image didFinishedSaving:(NSError *)error contextInfo:(void *)context{
  [UIView animateWithDuration:FLASH_DURATION animations:^{
    [self.flashView setAlpha:0.0f];
  }];
  
  [self showSuccessView];
}
@end

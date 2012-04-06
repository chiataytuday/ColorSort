//
//  SuccessView.m
//  ColorTest
//
//  Created by Frankie Laguna on 4/5/12.
//  Copyright (c) 2012 Frankie Laguna. All rights reserved.
//

#import "SuccessView.h"

#import <QuartzCore/QuartzCore.h>

#import "SuccessButtonDelegate.h"

#define MARGIN_Y 24.0f

@implementation SuccessView
@synthesize delegate;

-(id)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  
  if (self) {
    [self setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.75f]];
    [self.layer setCornerRadius:3.0f];
    
    CGFloat midX = CGRectGetWidth(frame) / 2;
    
    //Thumbs Up
    UIImage *thumbsUpImage = [UIImage imageNamed:@"icon-thumbs-up"];
    UIImageView *thumbImageView = [[UIImageView alloc] initWithImage:thumbsUpImage];
    
    CGRect thumbFrame = CGRectMake(round(midX - (thumbsUpImage.size.width / 2)), MARGIN_Y, thumbsUpImage.size.width, thumbsUpImage.size.height);
    [thumbImageView setFrame:thumbFrame];
    
    //Horizontal Line
    CGFloat lineY = CGRectGetMaxY(thumbFrame) + 10.0f;
    
    UIView *horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(round(midX - 20.0f), lineY, 40.0f, 1.0f)];
    [horizontalLine setBackgroundColor:[UIColor whiteColor]];
    
    //Next
    UIImage *rightArrowImage = [UIImage imageNamed:@"icon-right-arrow"];
    
    CGRect arrowFrame = CGRectMake(round(midX - (rightArrowImage.size.width / 2)), 0, rightArrowImage.size.width, rightArrowImage.size.height);
    arrowFrame.origin.y = lineY + 13.0f;
    
    UIButton *arrowButton = [[UIButton alloc] initWithFrame:arrowFrame];
    [arrowButton setImage:rightArrowImage forState:UIControlStateNormal];
    [arrowButton addTarget:self.delegate action:@selector(nextLevel) forControlEvents:UIControlEventTouchUpInside];
    
    //Replay
    UIImage *refreshImage = [UIImage imageNamed:@"icon-refresh"];
    
    CGRect refreshFrame = CGRectMake(round(midX - (refreshImage.size.width / 2)), 0, refreshImage.size.width, refreshImage.size.height);
    refreshFrame.origin.y = CGRectGetMaxY(arrowFrame) + 21.0f;
    
    UIButton *refreshButton = [[UIButton alloc] initWithFrame:refreshFrame];
    [refreshButton setImage:refreshImage forState:UIControlStateNormal];
    [refreshButton addTarget:self.delegate action:@selector(replay) forControlEvents:UIControlEventTouchUpInside];
    
    //Home
    UIImage *homeImage = [UIImage imageNamed:@"icon-home"];
    
    CGRect homeFrame = CGRectMake(round(midX - (homeImage.size.width / 2)), 0, homeImage.size.width, homeImage.size.height);
    homeFrame.origin.y = CGRectGetMaxY(refreshFrame) + 21.0f;
    
    UIButton *homeButton = [[UIButton alloc] initWithFrame:homeFrame];
    [homeButton setImage:homeImage forState:UIControlStateNormal];
    [homeButton addTarget:self.delegate action:@selector(popToHome) forControlEvents:UIControlEventTouchUpInside];
    
    //Camera
    UIImage *cameraImage = [UIImage imageNamed:@"icon-camera"];
    
    CGRect cameraFrame = CGRectMake(round(midX - (cameraImage.size.width / 2)), 0, cameraImage.size.width, cameraImage.size.height);
    cameraFrame.origin.y = CGRectGetMaxY(homeFrame) + 21.0f;
    
    UIButton *cameraButton = [[UIButton alloc] initWithFrame:cameraFrame];
    [cameraButton setImage:cameraImage forState:UIControlStateNormal];
    [cameraButton addTarget:self.delegate action:@selector(takeScreenshot) forControlEvents:UIControlEventTouchUpInside];
    
    
    //Add em up!
    [self addSubview:thumbImageView];
    [self addSubview:horizontalLine];
    [self addSubview:arrowButton];
    [self addSubview:refreshButton];     
    [self addSubview:homeButton];
    [self addSubview:cameraButton];
  }
  
  return self;
}
@end

//
//  SuccessView.m
//  ColorTest
//
//  Created by Frankie Laguna on 4/5/12.
//  Copyright (c) 2012 Frankie Laguna. All rights reserved.
//

#import "SuccessView.h"

#import "OverlayButtonDelegate.h"

@implementation SuccessView
-(id)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  
  if (self) {
    CGFloat midX = CGRectGetWidth(self.bounds) / 2.0f; //Get the middle X position of the view
    
    //Thumbs Up
    UIImage *thumbsUpImage = [UIImage imageNamed:@"icon-thumbs-up"];
    UIImageView *thumbImageView = [[UIImageView alloc] initWithImage:thumbsUpImage];
    
    CGRect thumbFrame = CGRectMake(
                                   round(midX - (thumbsUpImage.size.width / 2)), 
                                   24.0f, 
                                   thumbsUpImage.size.width, 
                                   thumbsUpImage.size.height
                        );
    
    [thumbImageView setFrame:thumbFrame];
    
    //Horizontal Line
    CGRect lineFrame = CGRectMake(round(midX - 20.0f), CGRectGetMaxY(thumbFrame) + 10.0f, 40.0f, 1.0f);
    
    UIView *horizontalLine = [[UIView alloc] initWithFrame:lineFrame];
    [horizontalLine setBackgroundColor:[UIColor whiteColor]];
    
    //Next
    UIButton *nextButton = [self buttonWithImageName:@"icon-right-arrow" 
                                             originY:CGRectGetMaxY(lineFrame) + 13.0f 
                                            selector:@selector(nextLevel)];
    
    UIButton *replayButton = [self buttonWithImageName:@"icon-refresh" 
                                               originY:CGRectGetMaxY(nextButton.frame) + 21.0f 
                                              selector:@selector(replay)];
    
    UIButton *homeButton = [self buttonWithImageName:@"icon-home" 
                                             originY:CGRectGetMaxY(replayButton.frame) + 21.0f 
                                            selector:@selector(popToHome)];
    
    UIButton *cameraButton = [self buttonWithImageName:@"icon-camera" 
                                               originY:CGRectGetMaxY(homeButton.frame) + 21.0f 
                                              selector:@selector(takeScreenshot)];
    
    //Add em up!
    [self addSubview:thumbImageView];
    [self addSubview:horizontalLine];
    [self addSubview:nextButton];
    [self addSubview:replayButton];     
    [self addSubview:homeButton];
    [self addSubview:cameraButton];
  }
  
  return self;
}

@end

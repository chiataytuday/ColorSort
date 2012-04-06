//
//  FailedView.m
//  ColorTest
//
//  Created by Frankie Laguna on 4/5/12.
//  Copyright (c) 2012 Frankie Laguna. All rights reserved.
//

#import "FailedView.h"

#import <QuartzCore/QuartzCore.h>

#import "FailedButtonDelegate.h"

#define MARGIN_X 20.0f
#define MARGIN_Y 16.0f
#define ICON_MARGIN 14.0f

@implementation FailedView
@synthesize delegate;

-(id)initWithFrame:(CGRect)frame{
  if(self = [super initWithFrame:frame]){
    [self setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.75f]];
    [self.layer setCornerRadius:3.0f];
    
    //Thumbs down button
    UIImage *thumbsDownImage = [UIImage imageNamed:@"icon-thumbs-down"];
    
    UIButton *levelSelectButton = [[UIButton alloc] initWithFrame:CGRectMake(MARGIN_X, MARGIN_Y, thumbsDownImage.size.width, thumbsDownImage.size.height)];
    [levelSelectButton setImage:thumbsDownImage forState:UIControlStateNormal];
    [levelSelectButton addTarget:self.delegate action:@selector(popToLevelSelect) forControlEvents:UIControlEventTouchUpInside];
    
    //Vertical Line
    UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(levelSelectButton.frame) + ICON_MARGIN, MARGIN_Y, 1, 40.0f)];
    [verticalLine setBackgroundColor:[UIColor whiteColor]];
    
    //Home button
    UIImage *homeImage = [UIImage imageNamed:@"icon-home"];
    
    UIButton *homeButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(verticalLine.frame) + ICON_MARGIN, MARGIN_Y, homeImage.size.width, homeImage.size.height)];
    [homeButton setImage:homeImage forState:UIControlStateNormal];
    [homeButton addTarget:self.delegate action:@selector(popToHome) forControlEvents:UIControlEventTouchUpInside];
    
    //Refresh button
    UIImage *refreshImage = [UIImage imageNamed:@"icon-refresh"];
    
    UIButton *refreshButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(homeButton.frame) + ICON_MARGIN, MARGIN_Y, refreshImage.size.width, refreshImage.size.height)];
    [refreshButton setImage:refreshImage forState:UIControlStateNormal];
    [refreshButton addTarget:self.delegate action:@selector(replay) forControlEvents:UIControlEventTouchUpInside];
    
    //Add them to the view
    [self addSubview:levelSelectButton];
    [self addSubview:verticalLine];
    [self addSubview:homeButton];
    [self addSubview:refreshButton];
  }
  
  return self;
}
@end

//
//  OverlayView.m
//  ColorSort
//
//  Created by Frankie Laguna on 4/6/12.
//  Copyright (c) 2012 Frankie Laguna. All rights reserved.
//

#import "OverlayView.h"

#import <QuartzCore/QuartzCore.h>

@implementation OverlayView
@synthesize delegate;

#pragma mark - Init
-(id)initWithFrame:(CGRect)frame{
  if(self = [super initWithFrame:frame]){
    [self setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.75f]];
    [self.layer setCornerRadius:3.0f];
  }
  
  return self;
}

#pragma - Public
-(UIButton *)buttonWithImageName:(NSString *)imageName originY:(CGFloat)originY selector:(SEL)selector{
  CGFloat midX = CGRectGetWidth(self.bounds) / 2.0f; //Get the middle X position of the view
  
  UIImage *image = [UIImage imageNamed:imageName];
  CGSize imageSize = image.size;
  
  CGRect buttonFrame = CGRectMake(round(midX - (imageSize.width / 2)), originY, imageSize.width, imageSize.height);
  
  UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
  [button setImage:image forState:UIControlStateNormal];
  [button addTarget:self.delegate action:selector forControlEvents:UIControlEventTouchUpInside];
  
  return button;
}

@end

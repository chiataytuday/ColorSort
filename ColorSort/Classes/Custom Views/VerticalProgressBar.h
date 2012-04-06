//
//  VerticalProgressBar.h
//  ColorTest
//
//  Created by Frankie Laguna on 4/5/12.
//  Copyright (c) 2012 Frankie Laguna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerticalProgressBar : UIView
@property(nonatomic) NSUInteger totalSeconds;
@property(nonatomic) CGFloat secondsLeft;

-(void)startTimer;
-(void)pauseTimer;
-(void)reset;
@end

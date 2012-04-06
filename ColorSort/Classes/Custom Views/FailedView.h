//
//  FailedView.h
//  ColorTest
//
//  Created by Frankie Laguna on 4/5/12.
//  Copyright (c) 2012 Frankie Laguna. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FailedButtonDelegate;

@interface FailedView : UIView
@property(weak, nonatomic) id<FailedButtonDelegate> delegate;
@end

//
//  SuccessView.h
//  ColorTest
//
//  Created by Frankie Laguna on 4/5/12.
//  Copyright (c) 2012 The Atom Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SuccessButtonDelegate;

@interface SuccessView : UIView
@property(weak, nonatomic) id<SuccessButtonDelegate> delegate;
@end

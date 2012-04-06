//
//  OverlayView.h
//  ColorSort
//
//  Created by Frankie Laguna on 4/6/12.
//  Copyright (c) 2012 Frankie Laguna. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OverlayButtonDelegate;

@interface OverlayView : UIView
@property(weak, nonatomic) id<OverlayButtonDelegate> delegate;

-(UIButton *)buttonWithImageName:(NSString *)imageName originY:(CGFloat)originY selector:(SEL)selector;
@end

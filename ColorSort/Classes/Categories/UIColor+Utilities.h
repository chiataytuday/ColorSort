//
//  UIColor+Utilities.h
//  ColorTest
//
//  Created by Frankie Laguna on 4/5/12.
//  Copyright (c) 2012 The Atom Group. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct{
  float min;
  float max;
} NumberRange;

@interface UIColor (Utilities)
+(UIColor *)randomColor;
+(UIColor *)toRGB:(UIColor *)color;
+(UIColor *)slightlyDarkerColor:(UIColor *)color;
+(NSArray *)rgbToHSBComponents:(UIColor *)color;
+(UIColor *)complementaryColorOfColor:(UIColor *)color;

+(UIColor *)reddishColor;
+(UIColor *)blueishColor;
+(UIColor *)greenishColor;
+(UIColor *)yellowishColor;
@end

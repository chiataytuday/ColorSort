//
//  UIColor+Utilities.m
//  ColorTest
//
//  Created by Frankie Laguna on 4/5/12.
//  Copyright (c) 2012 Frankie Laguna. All rights reserved.
//

#import "UIColor+Utilities.h"
#import "ColorSpaceUtilities.h"

#define MAX_HUE 360.0f
#define MAX_SATURATION 100.0f
#define MAX_BRIGHTNESS 100.0f

@implementation UIColor (Utilities)
+(UIColor *)randomColor{    
  CGFloat h = (fmod(arc4random(), (MAX_HUE - 0)) + 0) / MAX_HUE;
  CGFloat s = (fmod(arc4random(), (MAX_SATURATION - 70.0f)) + 70.0f) / MAX_SATURATION;
  CGFloat b = (fmod(arc4random(), (MAX_BRIGHTNESS - 70.0f)) + 70.0f) / MAX_BRIGHTNESS;
  
  return [UIColor colorWithHue:h saturation:s brightness:b alpha:1.0f];
}

+(UIColor *)toRGB:(UIColor *)color{
  CGColorRef colorRef = color.CGColor;
  
  CGColorSpaceModel colorModel = CGColorSpaceGetModel(CGColorGetColorSpace(colorRef));
  
  if(colorModel == kCGColorSpaceModelMonochrome){
    const float *components = CGColorGetComponents(colorRef);
    
    color = [UIColor colorWithRed:components[0] green:components[0] blue:components[0] alpha:components[1]];
  }
  
  return color;
}

+(UIColor *)slightlyDarkerColor:(UIColor *)color{
  color = [UIColor toRGB:color];
  
  NSArray *hsbComponents = [UIColor rgbToHSBComponents:color];
  
  CGFloat hue = [[hsbComponents objectAtIndex:0] floatValue];
  CGFloat saturation = [[hsbComponents objectAtIndex:1] floatValue];
  
  NSInteger randomNumber = (arc4random() % 45);  
  CGFloat brightness = ((CGFloat)randomNumber / 100.0f);

  return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0f];
}

+(NSArray *)rgbToHSBComponents:(UIColor *)color{
  color = [UIColor toRGB:color];
  
  const float *components = CGColorGetComponents(color.CGColor);
  
  float hue = 0.0f;
  float saturation = 0.0f;
  float brightness = 0.0f;
  
  RGB2HSL(components[0], components[1], components[2], &hue, &saturation, &brightness);
  
  return [NSArray arrayWithObjects:[NSNumber numberWithFloat:hue], [NSNumber numberWithFloat:saturation], [NSNumber numberWithFloat:brightness], nil];
}

+(UIColor *)complementaryColorOfColor:(UIColor *)color{
  color = [UIColor toRGB:color];
  
  NSArray *hsbComponents = [UIColor rgbToHSBComponents:color];
  
  CGFloat hue = [[hsbComponents objectAtIndex:0] floatValue];
  CGFloat saturation = [[hsbComponents objectAtIndex:1] floatValue];
  CGFloat brightness = [[hsbComponents objectAtIndex:2] floatValue];
  
  hue += saturation;
  
  while(hue >= 360.0f){
    hue -= 360.0f;
  }
  
  while(hue < 0.0f){
    hue += 360.0f;
  }
  
  return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0f];
}

+(UIColor *)randomColorWithHueRange:(NumberRange)hueRange saturationRange:(NumberRange)saturationRange brightnessRange:(NumberRange)brightnessRange{
  CGFloat h = (fmod(arc4random(), (hueRange.max - hueRange.min)) + hueRange.min) / MAX_HUE;
  CGFloat s = (fmod(arc4random(), (saturationRange.max - saturationRange.min)) + saturationRange.min) / MAX_SATURATION;
  CGFloat b = (fmod(arc4random(), (brightnessRange.max - brightnessRange.min)) + brightnessRange.min) / MAX_BRIGHTNESS;
  
  return [UIColor colorWithHue:h saturation:s brightness:b alpha:1.0f];
}

+(UIColor *)reddishColor{
  NumberRange hueRange;
  hueRange.min = 300.0f;
  hueRange.max = 360.0f;

  NumberRange saturationRange;
  saturationRange.min = 50.0f;
  saturationRange.max = 100.0f;

  NumberRange brightnessRange;
  brightnessRange.min = 75.0f;
  brightnessRange.max = 100.0f;
  
  return [UIColor randomColorWithHueRange:hueRange saturationRange:saturationRange brightnessRange:brightnessRange];
}

+(UIColor *)blueishColor{
  NumberRange hueRange;
  hueRange.min = 185.0f;
  hueRange.max = 230.0f;
  
  NumberRange saturationRange;
  saturationRange.min = 60.0f;
  saturationRange.max = 100.0f;
  
  NumberRange brightnessRange;
  brightnessRange.min = 70.0f;
  brightnessRange.max = 100.0f;
  
  return [UIColor randomColorWithHueRange:hueRange saturationRange:saturationRange brightnessRange:brightnessRange];
}

+(UIColor *)greenishColor{
  NumberRange hueRange;
  hueRange.min = 95.0f;
  hueRange.max = 175.0f;
  
  NumberRange saturationRange;
  saturationRange.min = 50.0f;
  saturationRange.max = 100.0f;
  
  NumberRange brightnessRange;
  brightnessRange.min = 75.0f;
  brightnessRange.max = 100.0f;
  
  return [UIColor randomColorWithHueRange:hueRange saturationRange:saturationRange brightnessRange:brightnessRange];  
}

+(UIColor *)yellowishColor{
  NumberRange hueRange;
  hueRange.min = 40.0f;
  hueRange.max = 90.0f;
  
  NumberRange saturationRange;
  saturationRange.min = 50.0f;
  saturationRange.max = 100.0f;
  
  NumberRange brightnessRange;
  brightnessRange.min = 75.0f;
  brightnessRange.max = 100.0f;
  
  return [UIColor randomColorWithHueRange:hueRange saturationRange:saturationRange brightnessRange:brightnessRange];  
}

@end

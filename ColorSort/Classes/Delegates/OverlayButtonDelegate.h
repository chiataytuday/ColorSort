//
//  OverlayButtonDelegate.h
//  ColorSort
//
//  Created by Frankie Laguna on 4/6/12.
//  Copyright (c) 2012 Frankie Laguna. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OverlayButtonDelegate <NSObject>
-(void)popToLevelSelect;
-(void)popToHome;
-(void)nextLevel;
-(void)replay;
-(void)takeScreenshot;
@end

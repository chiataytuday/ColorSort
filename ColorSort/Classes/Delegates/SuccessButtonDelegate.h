//
//  SuccessButtonDelegate.h
//  ColorTest
//
//  Created by Frankie Laguna on 4/5/12.
//  Copyright (c) 2012 The Atom Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SuccessButtonDelegate <NSObject>
@required
-(void)nextLevel;
-(void)replay;
-(void)popToHome;
-(void)takeScreenshot;
@end

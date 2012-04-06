//
//  FailedButtonDelegate.h
//  ColorTest
//
//  Created by Frankie Laguna on 4/5/12.
//  Copyright (c) 2012 The Atom Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FailedButtonDelegate <NSObject>
@required
-(void)popToLevelSelect;
-(void)popToHome;
-(void)replay;

@end

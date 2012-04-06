//
//  ViewController.h
//  ColorTest
//
//  Created by Frankie Laguna on 4/4/12.
//  Copyright (c) 2012 Frankie Laguna. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FailedButtonDelegate.h"
#import "SuccessButtonDelegate.h"

@interface ViewController : UIViewController<FailedButtonDelegate, SuccessButtonDelegate>

@end

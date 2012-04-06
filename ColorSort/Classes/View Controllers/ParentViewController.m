//
//  ParentViewController.m
//  ColorSort
//
//  Created by Frankie Laguna on 4/6/12.
//  Copyright (c) 2012 Frankie Laguna. All rights reserved.
//

#import "ParentViewController.h"

@interface ParentViewController ()
@end

@implementation ParentViewController

+(id)controller{
  NSString *xibName = NSStringFromClass([self class]);
  
  UIViewController *returnController = nil;
  
  //Using type nib because xib gives a false negative
  if([[NSBundle mainBundle] pathForResource:xibName ofType:@"nib"] != nil){    
    returnController = [[self alloc] initWithNibName:xibName bundle:nil];
  }
  else{
    returnController = [[self alloc] init];
  }
  
  return returnController;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
  return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end

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

#pragma mark - Init
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

#pragma mark - View Life Cycle
-(void)viewDidLoad{
  [super viewDidLoad];
  
  //Hide the status bar, and update the view to fill the screen
  [[UIApplication sharedApplication] setStatusBarHidden:YES];
  
  [self.view setFrame:[[UIScreen mainScreen] bounds]];  
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
  return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end

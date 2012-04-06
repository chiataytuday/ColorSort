//
//  SegmentView.m
//  ColorTest
//
//  Created by Frankie Laguna on 4/4/12.
//  Copyright (c) 2012 Frankie Laguna. All rights reserved.
//

#import "SegmentView.h"

@interface SegmentView()
@property(strong, nonatomic) UILabel *label;
@property(strong, nonatomic) UILabel *orderLabel;
@property(nonatomic) BOOL debugging;
@end

@implementation SegmentView
@synthesize index = _index;
@synthesize order = _order;
@synthesize label, orderLabel;
@synthesize debugging;

/*
-(id)initWithFrame:(CGRect)frame{
  if(self = [super initWithFrame:frame]){
    [self setDebugging:YES];
  }
  
  return self;
}
 */

-(void)setIndex:(NSUInteger)index{
  _index = index;
  
  if(self.debugging){
    if(!self.label){
      self.label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0, 50.0f, CGRectGetHeight(self.frame))];
      [self.label setBackgroundColor:[UIColor clearColor]];
      [self.label setShadowColor:[UIColor colorWithWhite:1.0f alpha:0.5f]];
      [self.label setShadowOffset:CGSizeMake(-1, 0)];
      [self addSubview:self.label];
    }
    
    [self.label setText:[NSString stringWithFormat:@"I: %i", _index]];
  }
}

-(void)setOrder:(NSUInteger)order{
  _order = order;
  
  if(self.debugging){
    if(!self.orderLabel){
      self.orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 0, 50.0f, CGRectGetHeight(self.frame))];
      [self.orderLabel setBackgroundColor:[UIColor clearColor]];
      [self.orderLabel setShadowColor:[UIColor colorWithWhite:1.0f alpha:0.5f]];
      [self.orderLabel setShadowOffset:CGSizeMake(-1, 0)];
      [self addSubview:self.orderLabel];
    }
  
    [self.orderLabel setText:[NSString stringWithFormat:@"O: %i", _order]];
  }
}


@end

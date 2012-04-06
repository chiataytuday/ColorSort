// From: http://stackoverflow.com/questions/791232/canonical-way-to-randomize-an-nsarray-in-objective-c
//
//  NSMutableArray+ArchUtils_Shuffle.h
//  ColorTest
//
//  Created by Frankie Laguna on 4/4/12.
//  Copyright (c) 2012 Frankie Laguna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (ArchUtils_Shuffle)
- (void)shuffle;
- (void)reverse;
@end

//
//  NSMutableArray+ArchUtils_Shuffle.m
//  ColorTest
//
//  Created by Frankie Laguna on 4/4/12.
//  Copyright (c) 2012 The Atom Group. All rights reserved.
//

#import "NSMutableArray+ArchUtils_Shuffle.h"

// Chooses a random integer below n without bias.
// Computes m, a power of two slightly above n, and takes random() modulo m,
// then throws away the random number if it's between n and m.
// (More naive techniques, like taking random() modulo n, introduce a bias 
// towards smaller numbers in the range.)
static NSUInteger random_below(NSUInteger n) {
  NSUInteger m = 1;
  
  // Compute smallest power of two greater than n.
  // There's probably a faster solution than this loop, but bit-twiddling
  // isn't my specialty.
  do {
    m <<= 1;
  } while(m < n);
  
  NSUInteger ret;
  
  do {
    ret = random() % m;
  } while(ret >= n);
  
  return ret;
}

@implementation NSMutableArray (ArchUtils_Shuffle)

- (void)shuffle {
  // http://en.wikipedia.org/wiki/Knuth_shuffle
  
  for(NSUInteger i = [self count]; i > 1; i--) {
    NSUInteger j = random_below(i);
    [self exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
  }
}

- (void)reverse {
  NSUInteger i = 0;
  NSUInteger j = [self count] - 1;
  while (i < j) {
    [self exchangeObjectAtIndex:i
              withObjectAtIndex:j];
    
    i++;
    j--;
  }
}
@end
//
//  PossibleResultTree.m
//  NumMatrixDemo
//
//  Created by ckm on 2018/11/8.
//  Copyright © 2018年 ckm. All rights reserved.
//

#import "PossibleResultTree.h"

@implementation PossibleResultTree

- (instancetype)init{
    self = [super init];
    if (self) {
        self.sons = [[NSMutableArray alloc] init];
    }
    return self;
}


@end

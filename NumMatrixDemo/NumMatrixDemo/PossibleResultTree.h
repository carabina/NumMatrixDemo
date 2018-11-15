//
//  PossibleResultTree.h
//  NumMatrixDemo
//
//  Created by ckm on 2018/11/8.
//  Copyright © 2018年 ckm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PossibleResultTree : NSObject

@property (nonatomic ,weak) PossibleResultTree *father;
@property (nonatomic ,strong) NSMutableArray *sons;

@property (nonatomic ,strong) NSArray *possibleResult;
@property (nonatomic ,assign) BOOL hasCalculated;

@end

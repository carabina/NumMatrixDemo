//
//  Matrix.h
//  NumMatrixDemo
//
//  Created by ckm on 2018/11/8.
//  Copyright © 2018年 ckm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    kSolutionTypeMultiple,
    kSolutionTypeUnique,
    kSolutionTypeNone
} SolutionType;

@interface Matrix : NSObject

@property (nonatomic ,strong) NSMutableArray *matrix;

@property (nonatomic ,assign) BOOL isUniqueSolution;

@property (nonatomic ,assign) BOOL hasEmpty;

//循环计算并求解；
- (SolutionType)updateToFindSolutionWithArray:(NSArray *)array;

//更新数据；
- (void)updateNumWithArray:(NSArray *)array;

//返回实际对应的矩阵，有多个值的数组为0，单一数值的数组返回当前值；
- (NSArray *)currentResult;

//可能的解
- (NSArray *)possibleResultArray;

@end

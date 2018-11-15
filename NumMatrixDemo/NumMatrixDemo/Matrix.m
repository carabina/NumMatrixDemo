//
//  Matrix.m
//  NumMatrixDemo
//
//  Created by ckm on 2018/11/8.
//  Copyright © 2018年 ckm. All rights reserved.
//

#import "Matrix.h"

@implementation Matrix

- (instancetype)init{
    self = [super init];
    if (self) {
        self.matrix = [[NSMutableArray alloc] init];
        //创建9行
        for (int i = 0; i<9; i++) {
            NSMutableArray *rowArr = [[NSMutableArray alloc] init];
            //每行创建9列
            for (int j = 0; j<9; j++) {
                NSMutableArray *numArr = [[NSMutableArray alloc] init];
                //每个位置都是[1-9]的数组
                for (int n = 1; n<10; n++) {
                    [numArr addObject:[NSNumber numberWithInteger:n]];
                }
                [rowArr addObject:numArr];
            }
            [self.matrix addObject:rowArr];
        }
    }
    return self;
}

- (SolutionType)updateToFindSolutionWithArray:(NSArray *)array
{
    //用array更新
    [self updateNumWithArray:array];
    if (self.hasEmpty) {
        return kSolutionTypeNone;
    }else if (self.isUniqueSolution) {
        return kSolutionTypeUnique;
    }
    //自身循环更新
    NSArray *recordClearnedArr = self.currentResult;
    while (!self.isUniqueSolution) {
        [self updateNumWithArray:self.currentResult];
        if (self.hasEmpty) {
            return kSolutionTypeNone;
        }else if ([self.currentResult isEqualToArray:recordClearnedArr]) {
            if (self.isUniqueSolution) {
                return kSolutionTypeUnique;
            }else{
                return kSolutionTypeMultiple;
            }
        }else
        {
            recordClearnedArr = self.currentResult;
        }
    }
    return kSolutionTypeUnique;
}

- (void)updateNumWithArray:(NSArray *)array{
    for (int i = 0; i<9; i++) {
        for (int j = 0; j<9; j++) {
            NSNumber *num = array[i][j];
            if (num.integerValue>0) {
                [self updateNum:num.integerValue row:i cloumn:j];
            }
        }
    }
}

- (void)updateNum:(NSInteger)num row:(NSInteger)row cloumn:(NSInteger)cloumn{
    for (int i = 0; i<9; i++) {
        for (int j = 0; j<9; j++) {
            NSMutableArray *numArr = self.matrix[i][j];
            if ((i == row)&&(j == cloumn)) {
                [numArr removeAllObjects];
                [numArr addObject:[NSNumber numberWithInteger:num]];
            }else if ((i == row)||(j == cloumn)||((i/3 == row/3)&&(j/3 == cloumn/3))){
                [numArr removeObject:[NSNumber numberWithInteger:num]];
            }
        }
    }
}

- (NSArray *)currentResult{
    NSMutableArray *currentResult = [NSMutableArray array];
    for (NSArray *rowArr in self.matrix) {
        NSMutableArray *newRowArr = [NSMutableArray array];
        for (NSArray *numArr in rowArr) {
            if (numArr.count == 1) {
                [newRowArr addObject:[numArr firstObject]];
            }else{
                [newRowArr addObject:@0];
            }
        }
        [currentResult addObject:newRowArr];
    }
    return currentResult;
}

- (NSArray *)possibleResultArray{
    NSMutableArray *possibleResultArray = [[NSMutableArray alloc] init];
    for (int i = 0; i<9; i++) {
        for (int j = 0; j<9; j++) {
            NSMutableArray *numArr = self.matrix[i][j];
            if (numArr.count>1) {
                for (NSNumber *num in numArr) {
                    Matrix *possibleResult = [[Matrix alloc] init];
                    [possibleResult updateToFindSolutionWithArray:self.currentResult];
                    [possibleResult updateNum:num.integerValue row:i cloumn:j];
                    [possibleResultArray addObject:possibleResult.currentResult];
                }
                return possibleResultArray;
            }
        }
    }
    return possibleResultArray;
}

- (BOOL)isUniqueSolution{
    for (NSArray *rowArr in self.matrix) {
        for (NSArray *numArr in rowArr) {
            if (numArr.count>1) {
                return NO;
            }
        }
    }
    return YES;
}

- (BOOL)hasEmpty{
    for (NSArray *rowArr in self.matrix) {
        for (NSArray *numArr in rowArr) {
            if (numArr.count==0) {
                return YES;
            }
        }
    }
    return NO;
}

- (NSString *)description{
    NSMutableString *desc = [NSMutableString string];
    BOOL hasEmpty = NO;
    BOOL hasMultiple = NO;
    for (NSArray *rowArr in self.matrix) {
        [desc appendString:@"\n"];
        for (NSArray *numArr in rowArr) {
//            for (int i = 0; i < 9; i++) {
//                if (i<numArr.count) {
//                    NSNumber *num = numArr[i];
//                    [desc appendString:num.stringValue];
//                }else
//                {
//                    [desc appendString:@" "];
//                }
//                if (numArr.count==0) {
//                    hasEmpty = YES;
//                }
//            }
            if (numArr.count==1) {
                NSNumber *num = numArr[0];
                [desc appendString:num.stringValue];
                [desc appendString:@","];
            }else if (numArr.count>1) {
                hasMultiple = YES;
                [desc appendString:@"0"];
                [desc appendString:@","];
            }else
            {
                hasEmpty = YES;
                [desc appendString:@"#"];
                [desc appendString:@","];
            }
        }
    }
    if (hasMultiple) {
        [desc appendString:@"\n结果包含未知值"];
    }
    if (hasEmpty) {
        [desc appendString:@"\n结果包含空值"];
    }
    return desc;
}

@end

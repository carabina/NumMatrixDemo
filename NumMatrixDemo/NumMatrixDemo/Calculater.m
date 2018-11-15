//
//  Calculater.m
//  NumMatrixDemo
//
//  Created by ckm on 2018/11/8.
//  Copyright © 2018年 ckm. All rights reserved.
//

#import "Calculater.h"
#import "PossibleResultTree.h"

int answerCount = 0;

@implementation Calculater

+ (void)calculateWithArray:(NSArray *)array{
    PossibleResultTree *tree = [[PossibleResultTree alloc] init];
    tree.possibleResult = array;
    [self calculateWithPossibleResultTree:tree];
}

+ (void)calculateWithPossibleResultTree:(PossibleResultTree *)tree{
    if (!tree.hasCalculated) {
        if (tree.sons.count>0) {
            BOOL hasCalculated = YES;
            for (PossibleResultTree *sonTree in tree.sons) {
                if (!sonTree.hasCalculated) {
                    hasCalculated = NO;
                    [self calculateWithPossibleResultTree:sonTree];
                    break;
                }
            }
            tree.hasCalculated = hasCalculated;
            if (tree.hasCalculated) {
                [self calculateWithPossibleResultTree:tree.father];
            }
        }else if (tree.possibleResult.count>0) {
            Matrix *matrix = [[Matrix alloc] init];
            SolutionType solutionType = [matrix updateToFindSolutionWithArray:tree.possibleResult];
            if (solutionType == kSolutionTypeUnique){
                NSLog(@"正确答案：%@",matrix);
                answerCount++;
                tree.hasCalculated = YES;
                [self calculateWithPossibleResultTree:tree.father];
//                exit(0);
            }else if (solutionType == kSolutionTypeNone) {
                tree.hasCalculated = YES;
                if (tree.father) {
                    [self calculateWithPossibleResultTree:tree.father];
                }else{
                    NSLog(@"%@", answerCount?[NSString stringWithFormat:@"共有%d个解",answerCount]:@"题目无解");
                }
            }else if (solutionType == kSolutionTypeMultiple){
                for (NSArray *possibleResult in matrix.possibleResultArray) {
                    PossibleResultTree *son = [[PossibleResultTree alloc] init];
                    son.possibleResult = possibleResult;
                    son.father = tree;
                    [tree.sons addObject:son];
                }
                [self calculateWithPossibleResultTree:tree.sons.firstObject];
            }
        }else if (tree.father) {
            tree.hasCalculated = YES;
            [self calculateWithPossibleResultTree:tree.father];
        }else{
            NSLog(@"%@", answerCount?[NSString stringWithFormat:@"共有%d个解",answerCount]:@"题目无解");
        }
    }else if (tree.father) {
        [self calculateWithPossibleResultTree:tree.father];
    }else{
        NSLog(@"%@", answerCount?[NSString stringWithFormat:@"共有%d个解",answerCount]:@"题目无解");
    }
}

@end

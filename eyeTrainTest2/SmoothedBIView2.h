//
//  SmoothedBIView2.h
//  eyeTrainTest2
//
//  Created by Sudikoff Lab iMac on 11/15/14.
//  Copyright (c) 2014 edu.dartmouth.dali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <math.h>

@interface SmoothedBIView2 : UIView

- (void)clear;
- (void)showAnswer;
- (int)calculateScore;
- (void)showScore:(UIImage *) gradeImage;

@end

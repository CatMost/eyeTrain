//
//  CollectionViewCell.h
//  eyeTrainTest2
//
//  Created by Sudikoff Lab iMac on 11/14/14.
//  Copyright (c) 2014 edu.dartmouth.dali. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewInCell;
@property (weak, nonatomic) IBOutlet UILabel *labelInCell;
@property (weak, nonatomic) IBOutlet UIButton *buttonInCell;


@end

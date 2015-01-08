//
//  CollectionViewController.h
//  eyeTrainTest2
//
//  Created by Sudikoff Lab iMac on 11/13/14.
//  Copyright (c) 2014 edu.dartmouth.dali. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSArray *cellImage, *cellLabel;
}


@end

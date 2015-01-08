//
//  CollectionViewController.m
//  eyeTrainTest2
//
//  Created by Sudikoff Lab iMac on 11/13/14.
//  Copyright (c) 2014 edu.dartmouth.dali. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (void)viewDidLoad
{
//    NSLog(@"Give me something!!!!!!!!!!!");
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    cellImage = [[NSArray alloc] initWithObjects:@"copy_draw.png", @"perspective_draw.png", @"image_draw.png", @"detail_draw.png", nil];
    cellLabel = [[NSArray alloc] initWithObjects:@"Copy Draw Training", @"Perspective Draw Training", @"Structural Draw Training", @"Detailed Draw Training", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [cellLabel count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CollectionViewCellID";
    
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.labelInCell.text = [cellLabel objectAtIndex:indexPath.item];
    cell.imageViewInCell.image = [UIImage imageNamed:[cellImage objectAtIndex:indexPath.item]];
//    cell.buttonInCell.titleLabel.text = [cellLabel objectAtIndex:indexPath.item];
    
    return cell;
}

@end

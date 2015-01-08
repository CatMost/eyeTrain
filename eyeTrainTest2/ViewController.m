//
//  ViewController.m
//  eyeTrainTest2
//
//  Created by Sudikoff Lab iMac on 11/11/14.
//  Copyright (c) 2014 edu.dartmouth.dali. All rights reserved.
//

#import "ViewController.h"
#import "SmoothedBIView.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet SmoothedBIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *modelView;
@property (weak, nonatomic) IBOutlet UIButton *nextLevelButton;

//- (IBAction)drawAgain:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nextLevelButton.hidden = YES;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)drawAgain:(id)sender {
    [self.backgroundView clear];
    self.nextLevelButton.hidden = YES;
}

- (IBAction)drawDone:(id)sender {
    [self.backgroundView showAnswer];
    
    if([self.backgroundView calculateScore] <= 500) {
        self.nextLevelButton.hidden = NO;
    }
}

- (IBAction)nextLevel:(id)sender {
    
}

@end

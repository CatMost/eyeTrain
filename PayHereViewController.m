//
//  PayHereViewController.m
//  eyeTrainTest2
//
//  Created by Sudikoff Lab iMac on 11/15/14.
//  Copyright (c) 2014 edu.dartmouth.dali. All rights reserved.
//

#import "PayHereViewController.h"

@interface PayHereViewController ()

@property (weak, nonatomic) IBOutlet UILabel *UrlLabel;
@property (strong, nonatomic) IBOutlet UIView *mainView;

@end

@implementation PayHereViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSMutableAttributedString *s =
    [[NSMutableAttributedString alloc] initWithString:@"Welcome to Black Lobster!"];
    
    [s addAttribute:NSBackgroundColorAttributeName
              value:[UIColor cyanColor]
              range:NSMakeRange(0, s.length)];
    
    _UrlLabel.attributedText = s;
    
	//See if touch was inside the label
	if (CGRectContainsPoint(_UrlLabel.frame, [[[event allTouches] anyObject] locationInView:_mainView]))
	{
		//Open webpage
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://blacklobsteracademy.com/"]];
	}
}


@end

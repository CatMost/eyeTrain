//
//  SmoothedBIView.m
//  eyeTrainTest2
//
//  Created by Sudikoff Lab iMac on 11/11/14.
//  Copyright (c) 2014 edu.dartmouth.dali. All rights reserved.
//

#import "SmoothedBIView.h"

@implementation SmoothedBIView
{
    UIBezierPath *path;
    UIImage *incrementalImage;
    UIImage *backgroundImage;
    UIImage *answerImage;
    UIImage *modelImage;
    UIImage *guideImage;
    
    // final score
    UIImage *gradeAImage;
    UIImage *gradeBImage;
    UIImage *gradeCImage;
    UIImage *gradeDImage;
    UIImage *gradeFImage;
    
    UIImageView* backgroundImageView;
    UIImageView* answerImageView;
    UIImageView* modelImageView;
    UIImageView* guideImageView;
    UIImageView* gradeImageView;
    
    CGPoint pts[5]; // we now need to keep track of the four points of a Bezier segment and the first control point of the next segment
    uint ctr;
}

- (void)initCommon
{
    // read in images
    backgroundImage = [UIImage imageNamed:@"background_paper.jpg"];
    answerImage = [UIImage imageNamed:@"answer.png"];
    modelImage = [UIImage imageNamed:@"model.png"];
    guideImage = [UIImage imageNamed:@"guide.png"];
    
    gradeAImage = [UIImage imageWithContentsOfFile: @"grades/grade_a.png"];
    gradeBImage = [UIImage imageNamed:@"grades/grade_b.png"];
    gradeCImage = [UIImage imageNamed:@"grades/grade_c_minus.png"];
    gradeDImage = [UIImage imageNamed:@"grades/grade_d.png"];
    gradeFImage = [UIImage imageWithContentsOfFile: @"Supporting Files/grades/grade_f.png"];
    
    
//    // background image view
//    backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
//    backgroundImageView.image = backgroundImage;
//    [self addSubview:backgroundImageView];
//    [self insertSubview:backgroundImageView aboveSubview:self];
//    [self insertSubview:backgroundImageView atIndex:0];
    
    // model image view
    modelImageView = [[UIImageView alloc] initWithFrame:CGRectMake(342, 375, 328, 547)];
    modelImageView.image = modelImage;
    [self addSubview:modelImageView];
    modelImageView.alpha = 0.5;
    
    // guide image view
    guideImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 32, 300, 288)];
    guideImageView.image = guideImage;
    [self addSubview:guideImageView];
    
    
    [self setMultipleTouchEnabled:NO];
    [self setBackgroundColor:[UIColor colorWithPatternImage:backgroundImage]];
//    [self setBackgroundColor:[UIColor whiteColor]];
    path = [UIBezierPath bezierPath];
    [path setLineWidth:8.0];
//    [self bringSubviewToFront:self];
//    [self changeOpacity:0.8f image:modelImage];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self initCommon];
    }
    return self;
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initCommon];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [incrementalImage drawInRect:rect];
    [path stroke];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ctr = 0;
    UITouch *touch = [touches anyObject];
    pts[0] = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    ctr++;
    pts[ctr] = p;
    if (ctr == 4)
    {
        pts[3] = CGPointMake((pts[2].x + pts[4].x)/2.0, (pts[2].y + pts[4].y)/2.0); // move the endpoint to the middle of the line joining the second control point of the first Bezier segment and the first control point of the second Bezier segment
        
        [path moveToPoint:pts[0]];
        [path addCurveToPoint:pts[3] controlPoint1:pts[1] controlPoint2:pts[2]]; // add a cubic Bezier from pt[0] to pt[3], with control points pt[1] and pt[2]
        
        [self setNeedsDisplay];
        // replace points and get ready to handle the next segment
        pts[0] = pts[3];
        pts[1] = pts[4];
        ctr = 1;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self drawBitmap];
    [self setNeedsDisplay];
    [path removeAllPoints];
    ctr = 0;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void)drawBitmap
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    
    if (!incrementalImage) // first time; paint background white
    {
        UIBezierPath *rectpath = [UIBezierPath bezierPathWithRect:self.bounds];
        [[UIColor colorWithPatternImage:backgroundImage] setFill];
//        [[UIColor whiteColor] setFill];
        [rectpath fill];
    }
    [incrementalImage drawAtPoint:CGPointZero];
    [[UIColor blackColor] setStroke];
    [path stroke];
    incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

- (void)clear
{
    answerImageView.image = nil;
    gradeImageView.image = nil;
    incrementalImage = nil;
    [self setNeedsDisplay];
}

- (void)showAnswer
{
    if(answerImageView.image) {
        return;
    }
    
    answerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(92, 289, 835, 720)];
    answerImageView.image = guideImage;
    answerImageView.alpha = 0.5; // transparency
    [self addSubview:answerImageView];
}


- (int)calculateScore
{
    int drawResult = [self analysePixels:incrementalImage] * 1.5;
    int targetResult = [self analysePixels:answerImage];
    
    int differenceValue = abs(drawResult - targetResult);
    
    if(differenceValue <= 500)
    {
        [self showScore:gradeAImage];
    }
    else if(differenceValue <= 2000)
    {
        [self showScore:gradeBImage];
    }
    else if(differenceValue <= 4000)
    {
        [self showScore:gradeCImage];
    }
    else if(differenceValue <= 7800)
    {
        [self showScore:gradeDImage];
    }
    else
    {
        [self showScore:gradeFImage];
    }
    
//    NSLog(@"incrementalImage --> Width Height %zu %zu", CGImageGetWidth(incrementalImage.CGImage), CGImageGetHeight(incrementalImage.CGImage));
//    NSLog(@"answerImage --> Width Height %zu %zu", CGImageGetWidth(answerImage.CGImage), CGImageGetHeight(answerImage.CGImage));
//    NSLog(@"backgroundImage --> Width Height %zu %zu", CGImageGetWidth(backgroundImage.CGImage), CGImageGetHeight(backgroundImage.CGImage));
//    NSLog(@"RGB %d %d", drawResult, targetResult);
    return differenceValue;
}

- (void)showScore:(UIImage *) gradeImage
{
    if(gradeImageView.image) {
        return;
    }
    
    gradeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(565, 40, 153, 134)];
    gradeImageView.image = gradeImage;
    [self addSubview:gradeImageView];
}

- (int)analysePixels:(UIImage *) image
    // need to add compare to check differenace of pixels
{
    int scoredPixelNumber = 0;

    if (image != nil) {
        CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
        const UInt8* data = CFDataGetBytePtr(pixelData);
        
        for(int x=0; x<image.size.width; x++)
        {
            for(int y=0; y<image.size.height; y++)
            {
                int pixelInfo = ((image.size.width * y) + x) * 4; // The image is png
                
                UInt8 red = data[pixelInfo];         // If you need this info, enable it
                UInt8 green = data[(pixelInfo + 1)]; // If you need this info, enable it
                UInt8 blue = data[pixelInfo + 2];    // If you need this info, enable it
                
                if(red <= 20 || green <= 20 || blue <= 20)
                {
//                    NSLog(@"RGB %d %d %d", red, green, blue);
                    scoredPixelNumber++;
                }
            }
        }
        CFRelease(pixelData);
    }
    
    return scoredPixelNumber;
}

@end


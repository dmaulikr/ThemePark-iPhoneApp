//
//  ShapViewController.m
//  ThemePark
//
//  Created by Ninglin Li on 6/9/13.
//  Copyright (c) 2013 Ninglin_Li. All rights reserved.
//

#import "ShapeViewController.h"
#import "RootViewController.h"
#import "AnswersViewController.h"
#import "InfoViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ShapeViewController ()

@end

@implementation ShapeViewController

// init all subimages, show all subviews and present standard answer at the beginning
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"math-background.png"]];
    
    [self initImages];
    [self showViews];
    [self answerPhotoMove];
}

// init random subviews images
-(void)initImages{
    [self shuffleImageIndex];
    NSArray *imageTypes = [[NSArray alloc] initWithObjects:@"cuboid",@"circle", nil];
    int rand = arc4random() % imageTypes.count;
    self.answerImage = [imageTypes objectAtIndex:rand];
    self.images = [[NSMutableArray alloc] init];
    for (int i = 0; i < 9; i++) {
        int index = [[self.indexArray objectAtIndex:i] intValue];
        NSString *imageName = [NSString stringWithFormat:@"%@-%d.png", self.answerImage,index];
        NSLog(@"imageName %@",imageName);
        [self.images addObject:[UIImage imageNamed:imageName]];
        NSLog(@"image %@", [UIImage imageNamed:imageName]);
    }
}

// show all subviews
-(void)showViews{
    NSLog(@"self.images count %d", self.images.count);
    for (int i = 1; i <= 9; i++) {
        UIButton *button = (UIButton*)[self.view viewWithTag:70 + i];
        NSString *imageName = [NSString stringWithFormat:@"%@-%d.png", self.answerImage, [[self.indexArray objectAtIndex:i-1] intValue]];
        NSLog(@"imageName %@",imageName);
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
}

// shuffle images array to get random arrangement of subimages
-(void)shuffleImageIndex{
    self.indexArray = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 9; i++) {
        [self.indexArray addObject:[NSNumber numberWithInt:i]];
    }
    for (int i = 0; i < 9; i++) {
        int rand = arc4random()% 9;
        [self.indexArray exchangeObjectAtIndex:i withObjectAtIndex:rand];
    }
}

// check user's answer base on each subview's image index is in order
-(void)checkAnswer{
    BOOL isShape = true;
    for (int i = 0; i < 8; i++) {
        NSLog(@" indexvalue at %d, %d", i, [[self.indexArray objectAtIndex:i] intValue]);
        if( [[self.indexArray objectAtIndex:i] intValue] != ([[self.indexArray objectAtIndex:i + 1] intValue] - 1)){
            isShape = false;
        }
    }
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSNumber *result = [NSNumber numberWithBool:isShape];
    [userDefault setObject:result forKey:@"isShape"];
    NSLog(@"isShape in shape controller: %d", isShape);
}

// present AnswersViewController
- (IBAction)submitAnswer:(id)sender {
    [self checkAnswer];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *answerType = @"ShapeView";
    [userDefault setObject:answerType forKey:@"Theme"];
    AnswersViewController *answerView = [[self storyboard ] instantiateViewControllerWithIdentifier:@"AnswersViewController" ];
    
    if(answerView == nil){
        NSLog(@"answerView in modal view show is nil");
    }
    // Create the navigation controller and present it modally.
    [answerView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	[self.navigationController pushViewController:answerView animated:YES];

}

// present RootViewController
- (IBAction)homePage:(id)sender {
    
    RootViewController *rootView = [[self storyboard ] instantiateViewControllerWithIdentifier:@"RootViewController" ];
    if( rootView == nil){
        NSLog(@"rootView in modal view show is nil");
    }
    
	// Create the navigation controller and present it modally.
    [rootView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	[self.navigationController pushViewController:rootView animated:YES];
}

// present InfoViewController
- (IBAction)showInfo:(id)sender {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@"ShapeView" forKey:@"Theme"];
    InfoViewController *infoView = [[self storyboard ] instantiateViewControllerWithIdentifier:@"InfoViewController" ];
    if( infoView == nil){
        NSLog(@"infoView in modal view show is nil");
    }
    
	// Create the navigation controller and present it modally.
    [infoView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	[self.navigationController pushViewController:infoView animated:YES];
    
}

- (IBAction)changPhoto:(id)sender {
    
    UIButton *button = (UIButton*)sender;
    int buttonIndex = button.tag - 70;
    NSLog(@"press button %d", button.tag);
    NSNumber *oldValue = [self.indexArray objectAtIndex:buttonIndex -1];
    NSNumber * newValue = nil;
    if ([oldValue intValue] != 9) {
        newValue = [NSNumber numberWithInt:[oldValue intValue] + 1 ];
    }else{
        newValue = [NSNumber numberWithInt: 1 ];
    }
    [self.indexArray replaceObjectAtIndex:buttonIndex-1 withObject:newValue];
    [self showViews];
}

// animinaton of answer photo at the beginning of the game
- (void)answerPhotoMove{
    
    CGRect offscreen = CGRectMake(0, 400, 80, 80);
    UIImageView* answerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.answerImage]];
    answerImage.frame = offscreen;
    [self.view addSubview:answerImage];
    [UIView animateWithDuration:2.0 delay: 0.0 options: UIViewAnimationOptionCurveEaseIn animations:^{
        answerImage.center = self.view.center;
    }completion:^(BOOL completed){
        [UIView animateWithDuration:1.0 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        answerImage.transform = CGAffineTransformScale(answerImage.transform, 20, 20);
        answerImage.alpha = 0.0;
        } completion:^(BOOL completed){
            [answerImage removeFromSuperview];
        }];
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

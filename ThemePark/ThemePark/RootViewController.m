//
//  ViewController.m
//  ThemePark
//
//  Created by Ninglin Li on 6/7/13.
//  Copyright (c) 2013 Ninglin_Li. All rights reserved.
//

#import "RootViewController.h"
#import "MathsController.h"
#import "SymmetricController.h"
#import "ShapeViewController.h"
#import "SplashViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

// hide navigation bar
-(void)viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
//    this part is for fulfill presentation requirement
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *isFirst = [userDefault objectForKey:@"isFirst"];
    if (isFirst == nil) {
        SplashViewController *splashView = [self.storyboard instantiateViewControllerWithIdentifier:@"SplashViewController"];
        [self presentViewController:splashView animated:NO completion:^{
            [self performSelector:@selector(dismissSplashViewController) withObject:nil afterDelay:1.0];
        }];
        [userDefault setObject:@"notFirst" forKey:@"isFirst"];
    }
    
    [super viewDidLoad];
}

// dismiss the splash view
-(void)dismissSplashViewController
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Splash view dismiss");
    }];
}

// button animination
// scale up and shink 2 times
- (void) viewDidAppear:(BOOL)animated{
    UIButton *mathButton = (UIButton*)[self.view viewWithTag:11];
    UIButton *symmetricButton = (UIButton*)[self.view viewWithTag:12];
    UIButton *shapeButton = (UIButton*)[self.view viewWithTag:13];
   
    mathButton.transform = CGAffineTransformMakeScale(1.2,1.2);
    symmetricButton.transform = CGAffineTransformMakeScale(1.2,1.2);
    shapeButton.transform = CGAffineTransformMakeScale(1.2,1.2);
    [UIView animateWithDuration:0.2f
                          delay:0.2f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                        
                         mathButton.alpha = 1;
                         [UIView setAnimationRepeatCount:2];
                         [UIView setAnimationRepeatAutoreverses:YES];
                         mathButton.transform = CGAffineTransformMakeScale(1,1);
                         symmetricButton.transform = CGAffineTransformMakeScale(1,1);
                         shapeButton.transform = CGAffineTransformMakeScale(1,1);
                     }
                     completion:^(BOOL finished){
                     }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// present SymmetricController
- (IBAction)showSymmetricsView:(id)sender {
	
    SymmetricController *symmetricView = [[self storyboard ] instantiateViewControllerWithIdentifier:@"SymmetricController" ];
    if(symmetricView == nil){
        NSLog(@"symmetricView in modal view show is nil");
    }

	// Create the navigation controller and present it modally.
    [symmetricView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	[self.navigationController pushViewController:symmetricView animated:YES];
	
}

// present MathsController
- (IBAction)showMathsView:(id)sender {
    MathsController *mathsView = [[self storyboard ] instantiateViewControllerWithIdentifier:@"MathsController" ];
    if(mathsView == nil){
        NSLog(@"mathsView in modal view show is nil");
    }
    
	// Create the navigation controller and present it modally.
    [mathsView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	[self.navigationController pushViewController:mathsView animated:YES];
    
}

// present ShapeViewController
- (IBAction)showShapeView:(id)sender {
    ShapeViewController *shapeView = [[self storyboard ] instantiateViewControllerWithIdentifier:@"ShapeViewController" ];
    if(shapeView == nil){
        NSLog(@"shapeView in modal view show is nil");
    }
    
	// Create the navigation controller and present it modally.
    [shapeView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	[self.navigationController pushViewController:shapeView animated:YES];
    
}
@end

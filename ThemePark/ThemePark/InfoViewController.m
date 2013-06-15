//
//  InfoViewController.m
//  ThemePark
//
//  Created by Ninglin Li on 6/10/13.
//  Copyright (c) 2013 Ninglin_Li. All rights reserved.
//

#import "InfoViewController.h"
#import "RootViewController.h"
#import "SymmetricController.h"
#import "ShapeViewController.h"
#import "MathsController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

// set detailTextField.text base on Theme
- (void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *userDefaule = [NSUserDefaults standardUserDefaults];
    NSString *theme = [userDefaule objectForKey:@"Theme"];
    if ([theme isEqualToString:@"MathsView"]) {
        self.detailTextView.text = @"Arithmetic or arithmetics is the most elementary branch of mathematics, for tasks ranging from simple day-to-day counting to advanced science and business calculations. \nIn common usage, it refers to the simpler properties when using the traditional operations of addition, subtraction, multiplication and division with smaller values of numbers. Please click right mark to hand in your answer.";
    }else if( [theme isEqualToString:@"ShapeView"] ){
        self.detailTextView.text = @"Click each subview to chang image and form a big image which is the same as answer.";
    }else if( [theme isEqualToString:@"SymmetricView"] ){
        self.detailTextView.text = @"Symmetry in Math - \"patterned self-similarity\" that can be demonstrated with the rules of a formal system, such as geometry or physics. \nTo win this game, there must be more than 4 puppet in each side.";
    }
}
// rotate titleLabel, detailTextView to the left
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"info-background.png"]];
    [self.titleLabel setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    [self.detailTextView setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    [self.detailTextView setEditable:NO];
}


// back to the theme page
- (IBAction)homePage:(id)sender {
    NSUserDefaults *userDefaule = [NSUserDefaults standardUserDefaults];
    NSString *theme = [userDefaule objectForKey:@"Theme"];
    
    if ([theme isEqualToString:@"MathsView"]) {
        MathsController *rootView = [[self storyboard ] instantiateViewControllerWithIdentifier:@"MathsController" ];
        if( rootView == nil){
            NSLog(@"rootView in modal view show is nil");
        }
        
        // Create the navigation controller and present it modally.
        [rootView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self.navigationController pushViewController:rootView animated:YES];

    }else if( [theme isEqualToString:@"ShapeView"] ){
        ShapeViewController *rootView = [[self storyboard] instantiateViewControllerWithIdentifier:@"ShapeViewController"];
        if( rootView == nil){
            NSLog(@"rootView in modal view show is nil");
        }
        
        // Create the navigation controller and present it modally.
        [rootView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self.navigationController pushViewController:rootView animated:YES];

    }else if( [theme isEqualToString:@"SymmetricView"] ){
        SymmetricController *rootView = [[self storyboard] instantiateViewControllerWithIdentifier:@"SymmetricController"];
        if( rootView == nil){
            NSLog(@"rootView in modal view show is nil");
        }
        
        // Create the navigation controller and present it modally.
        [rootView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self.navigationController pushViewController:rootView animated:YES];
    }

  }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

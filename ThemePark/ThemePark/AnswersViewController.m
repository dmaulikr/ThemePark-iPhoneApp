//
//  AnswersViewController.m
//  ThemePark
//
//  Created by Ninglin Li on 6/10/13.
//  Copyright (c) 2013 Ninglin_Li. All rights reserved.
//

#import "AnswersViewController.h"
#import "SymmetricController.h"
#import "RootViewController.h"
#import "ShapeViewController.h"
#import "MathsController.h"
#import <QuartzCore/QuartzCore.h>

@interface AnswersViewController ()

@end

@implementation AnswersViewController

// set title and subtitle text base on theme
-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
   
    NSString *answerType = [userDefault objectForKey:@"Theme"];
    if ([answerType isEqualToString:@"ShapeView"]) {
        NSNumber *rightAnswer = [userDefault objectForKey:@"isShape"];
        BOOL isRightAnswer = [rightAnswer boolValue];
        NSLog(@"isShape %d", isRightAnswer);
        if (isRightAnswer) {
            self.titleLabel.text = @"Congratulations";
            NSLog(@"show label : %@",self.titleLabel.text);
            self.subtitleLabel.text = @"You find right shape!";
        }else{
            self.titleLabel.text = @"Sorry";
            NSLog(@"show label : %@",self.titleLabel.text);
            self.subtitleLabel.text = @"You did not find the right shape!";
        }
    }else if ([answerType isEqualToString:@"SymmetricView"]){
        NSNumber *right = [userDefault objectForKey:@"isSymmetric"];
        BOOL isRightAnswer = [right boolValue];
        if (isRightAnswer) {
            
            self.titleLabel.text = @"Congratulations";
            NSLog(@"show label : %@",self.titleLabel.text);
            self.subtitleLabel.text = @"You find right symmetric pattern!";
        }else{
            self.titleLabel.text = @"Sorry";
            NSLog(@"show label : %@",self.titleLabel.text);
            self.subtitleLabel.text = @"You did not find the right symmetric pattern!";
        }
    }else if ([answerType isEqualToString:@"MathsView"]){
        NSNumber *symmetric = [userDefault objectForKey:@"isRightNumber"];
        BOOL isSymmetric = [symmetric boolValue];
        if (isSymmetric) {
            self.titleLabel.text = @"Congratulations";
            NSLog(@"show label : %@",self.titleLabel.text);
            self.subtitleLabel.text = @"You find right answer!";
        }else{
            self.titleLabel.text = @"Sorry";
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            NSNumber *answer = [userDefault objectForKey:@"MathAnswer"];
            self.subtitleLabel.text = [NSString stringWithFormat:@"%@ %@", @"The right answer is", answer];
        }
    }
}

// rotate titleLabel, subtitleLabel, playButton and okButton to the left
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.titleLabel setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    [self.subtitleLabel setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    [self.playButton setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    [self.okButton setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    self.playButton.layer.cornerRadius = 20;
     self.okButton.layer.cornerRadius = 20;
}
// present RootViewController
- (IBAction)dismissInfo:(id)sender {
    RootViewController *rootView = [[self storyboard ] instantiateViewControllerWithIdentifier:@"RootViewController" ];
    if(rootView == nil){
        NSLog(@"rootView in modal view show is nil");
    }
    
	// Create the navigation controller and present it modally.
    [rootView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	[self.navigationController pushViewController:rootView animated:YES];
}
// got back to the theme page and play the game again
- (IBAction)playAgain:(id)sender {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *answerType = [userDefault objectForKey:@"Theme"];
    if ([answerType isEqualToString:@"ShapeView"]) {

        ShapeViewController *shapeView = [[self storyboard ] instantiateViewControllerWithIdentifier:@"ShapeViewController" ];
        if(shapeView == nil){
            NSLog(@"shapeView in modal view show is nil");
        }
        
        // Create the navigation controller and present it modally.
        [shapeView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self.navigationController pushViewController:shapeView animated:YES];
    }else if ([answerType isEqualToString:@"SymmetricView"]){
        SymmetricController *symmetricView = [[self storyboard ] instantiateViewControllerWithIdentifier:@"SymmetricController" ];
        if(symmetricView == nil){
            NSLog(@"symmetricView in modal view show is nil");
        }
    
        // Create the navigation controller and present it modally.
        [symmetricView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self.navigationController pushViewController:symmetricView animated:YES];
    }else if([answerType isEqualToString:@"MathsView"]){
        MathsController *mathsView = [[self storyboard ] instantiateViewControllerWithIdentifier:@"MathsController" ];
        if(mathsView == nil){
            NSLog(@"mathsView in modal view show is nil");
        }
        
        // Create the navigation controller and present it modally.
        [mathsView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self.navigationController pushViewController:mathsView animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

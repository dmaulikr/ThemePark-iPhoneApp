//
//  SplashViewController.m
//  ThemePark
//
//  Created by Ninglin Li on 6/12/13.
//  Copyright (c) 2013 Ninglin_Li. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
//     self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"theme.png"]];
    
    [self.themepark setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    [self.name setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

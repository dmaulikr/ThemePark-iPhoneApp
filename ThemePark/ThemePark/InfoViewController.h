//
//  InfoViewController.h
//  ThemePark
//
//  Created by Ninglin Li on 6/10/13.
//  Copyright (c) 2013 Ninglin_Li. All rights reserved.
//

// present instruction, information of each theme
#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *detailTextView;
- (IBAction)homePage:(id)sender;

@end

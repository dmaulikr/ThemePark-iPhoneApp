//
//  AnswersViewController.h
//  ThemePark
//
//  Created by Ninglin Li on 6/10/13.
//  Copyright (c) 2013 Ninglin_Li. All rights reserved.
//

// present answer page for all theme
#import <UIKit/UIKit.h>

@interface AnswersViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *subtitleLabel;

@property (strong, nonatomic) IBOutlet UIButton *okButton;
@property (strong, nonatomic) IBOutlet UIButton *playButton;

- (IBAction)dismissInfo:(id)sender;
- (IBAction)playAgain:(id)sender;


@end

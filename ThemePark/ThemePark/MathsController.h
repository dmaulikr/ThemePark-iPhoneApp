//
//  SymmetricController.h
//  ThemePark
//
//  Created by Ninglin Li on 6/7/13.
//  Copyright (c) 2013 Ninglin_Li. All rights reserved.

// arithmetic questions
// there are 8 robots and one of them has the right answer
// user need to findout the right answer
#import <UIKit/UIKit.h>

@interface MathsController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *questionLabel;
@property (strong, nonatomic) NSMutableArray *sampleAnswers;
@property (strong, nonatomic) NSString *operator;
@property (nonatomic) NSInteger answer;


- (IBAction)backHome:(id)sender;
- (IBAction)checkAnswer:(id)sender;
- (IBAction)showinfo:(id)sender;

@end

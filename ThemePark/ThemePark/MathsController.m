//
//  SymmetricController.m
//  ThemePark
//
//  Created by Ninglin Li on 6/7/13.
//  Copyright (c) 2013 Ninglin_Li. All rights reserved.
//

#import "MathsController.h"
#import "RootViewController.h"
#import "AnswersViewController.h"
#import "InfoViewController.h"

@interface MathsController ()

@end

@implementation MathsController

// init question and sample answers on each robot
- (void)viewWillAppear:(BOOL)animated{
    [self initQuestion];
    [self setButtonTitle];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"math-background.png"]];
    for (int i = 1; i <= 8; i++) {
        UIButton * button = (UIButton*)[self.view viewWithTag: 40 + i];
        [button setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
//        run robbots
        [self buttonMoveHorizontally:button];
    }
    
    [self.questionLabel setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
}

// init question as addition, subtraction, multiplication, division
// init two random int and a symbol from +, -, *, /
-(void)initQuestion{
    NSInteger operant1 = arc4random() % 20;
    NSInteger operant2 = arc4random() % 40;
    NSArray * operators = [[NSArray alloc] initWithObjects:@"+",@"-",@"*",@"/", nil];
    int randIndex = arc4random() % operators.count;
    self.questionLabel.text = [NSString stringWithFormat:@"%d %@ %d = ?", operant2, [operators objectAtIndex:randIndex], operant1];
    if (randIndex == 0 ) {
        self.answer = operant2 + operant1;
    }else if( randIndex == 1 ){
        self.answer = operant2 - operant1;
    }else if( randIndex == 2 ){
        self.answer = operant2 * operant1;
    }else{
//        round up
        self.answer = (operant2 +operant1 - 1)/ operant1;
    }
    NSLog(@"answer %d", self.answer);
//    store standard answer in nsuserdefault for later show in AnswerViewController
    NSUserDefaults *userDefalut = [NSUserDefaults standardUserDefaults];
    [userDefalut setObject:[NSNumber numberWithInt: self.answer] forKey:@"MathAnswer"];
//    init sampleanswers which will show in robots
    [self initSampleAnswer:self.answer];
}

// init random non repeat sample answers 
-(void)initSampleAnswer:(NSInteger)answer{
    self.sampleAnswers = [[NSMutableArray alloc] init];
    NSMutableArray * sampleNumber = [[NSMutableArray alloc] init];
    for (int i = 0; i < 39; i++) {
        if ( i != 10) {
            NSNumber * number = [NSNumber numberWithInt:answer -10 + i];
            [sampleNumber addObject:number];
        }
    }
    for (int i = 0; i < 7; i++) {
        int rand =  arc4random() % sampleNumber.count;
        [self.sampleAnswers addObject:[sampleNumber objectAtIndex:rand]];
        [sampleNumber removeObjectAtIndex:rand];
    }
    [self.sampleAnswers addObject:[NSNumber numberWithInt:answer]];
    int randIndex = arc4random()% 7;
    [self.sampleAnswers exchangeObjectAtIndex:7 withObjectAtIndex:randIndex];
    NSLog(@"sampleAnswers count %d", self.sampleAnswers.count);
    
}

// set buttons title with sampleAnswers
- (void)setButtonTitle{
    for (int i = 0; i < 8; i++ ) {
        UIButton *button = (UIButton *)[self.view viewWithTag:41 + i];
        NSString * title = [NSString stringWithFormat:@"%d", [[self.sampleAnswers objectAtIndex:i] intValue]];
        [button setTitle: title forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22.0]];
    }
}

// animinate robot move left to right
- (void)robotsRun{
    for (int i = 1; i <= 8; i++) {
        UIButton *button = (UIButton*)[self.view viewWithTag:40 + i];
        [self buttonMoveHorizontally:button];
    }
}

// button animination
- (void)buttonMoveHorizontally:(UIButton*)button{
    float times = 2.0f;
    int x = button.center.x;
    int y = button.center.y;
    float hight = button.bounds.size.height;
    [UIView animateWithDuration:0.5f
                          delay:0.2f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         button.alpha = 1;
                         [UIView setAnimationRepeatCount:times];
                         [UIView setAnimationRepeatAutoreverses:YES];
                         CGPoint center = CGPointMake(x, y-hight/2);
                         if (button.center.y > center.y) {
                             button.center = center;
                             center.y += hight/2;
                         }else{
                             button.center = center;
                             center.y -= hight/2;
                         }
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             [UIView animateWithDuration:0.5 delay:0.0
                                                 options:UIViewAnimationOptionCurveEaseIn
                                              animations:^{
                                                  [button setCenter:CGPointMake(x, y)];
                                              }
                                              completion:nil];
                         }
                     }];

}

// go back to home page
- (IBAction)backHome:(id)sender {
    
    RootViewController *rootView = [[self storyboard ] instantiateViewControllerWithIdentifier:@"RootViewController" ];
    if( rootView == nil){
        NSLog(@"rootView in modal view show is nil");
    }
    
	// Create the navigation controller and present it modally.
    [rootView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	[self.navigationController pushViewController:rootView animated:YES];
}

// check the user's answer with standard answer
// if match, isRight is true, otherwish is false
- (IBAction)checkAnswer:(id)sender {
    BOOL isRight = false;
    UIButton *button = (UIButton*)sender;
    NSInteger choiceAnswer = [[self.sampleAnswers objectAtIndex:button.tag - 41] intValue];
    if (choiceAnswer == self.answer) {
        isRight = true;
    }else{
        isRight = false;
    }
    [self showAnswer:isRight];
}

// present InfoViewController 
- (IBAction)showinfo:(id)sender{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@"MathsView" forKey:@"Theme"];
    InfoViewController *infoView = [[self storyboard ] instantiateViewControllerWithIdentifier:@"InfoViewController" ];
    if( infoView == nil){
        NSLog(@"infoView in modal view show is nil");
    }
    
	// Create the navigation controller and present it modally.
    [infoView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	[self.navigationController pushViewController:infoView animated:YES];
}

// present AnswersViewController base on the user choose a right answer or not
- (void)showAnswer:(BOOL)isRight{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSNumber *right = [NSNumber numberWithBool:isRight];
    [userDefault setObject:right forKey:@"isRightNumber"];
//    set Theme because AnswersViewController present base on theme
    NSString *answerType = @"MathsView";
    [userDefault setObject:answerType forKey:@"Theme"];
    AnswersViewController *answerView = [[self storyboard ] instantiateViewControllerWithIdentifier:@"AnswersViewController" ];
    
    if(answerView == nil){
        NSLog(@"mathsView in modal view show is nil");
    }
    // Create the navigation controller and present it modally.
    [answerView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	[self.navigationController pushViewController:answerView animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

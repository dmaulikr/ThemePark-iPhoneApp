//
//  MathController.m
//  ThemePark
//
//  Created by Ninglin Li on 6/8/13.
//  Copyright (c) 2013 Ninglin_Li. All rights reserved.
//

#import "SymmetricController.h"
#import "RootViewController.h"
#import "AnswersViewController.h"
#import "InfoViewController.h"

@interface SymmetricController ()
@end

@implementation SymmetricController

-(void)viewWillAppear:(BOOL)animated{
//    set background image
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"symmetric-background.png"]];
    
    self.leftPuppets = [[NSMutableArray alloc] init];
    self.rightPuppets = [[NSMutableArray alloc] init];
    [self initLeftPuppet];
    [self initRightPuppet];
    [self showPuppet];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}


// delete puppet if this puppet being touched
- (IBAction)deletePuppet:(id)sender {
    int tag = [(UIButton*)sender tag];
    if (tag > 60 ) {
        NSNumber *object = [NSNumber numberWithInt:tag - 60];
        [self.leftPuppets removeObject:object];
    }else{
        NSNumber *object = [NSNumber numberWithInt:tag - 50];
        [self.rightPuppets removeObject:object];
    }
    [self showPuppet];
}

//show math info and game rules
- (IBAction)showInfo:(id)sender {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@"SymmetricView" forKey:@"Theme"];
    InfoViewController *infoView = [[self storyboard ] instantiateViewControllerWithIdentifier:@"InfoViewController" ];
    if( infoView == nil){
        NSLog(@"infoView in modal view show is nil");
    }
    
	// Create the navigation controller and present it modally.
    [infoView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	[self.navigationController pushViewController:infoView animated:YES];
}

// check user's answer
// if rightPuppets.count != self.leftPuppets.count, isSymmetric-> false
// every rightPuppet match leftPuppet, isSymmetric->ture
- (IBAction)uploadAnswer:(id)sender {
    Boolean isSymmetric = true;
    
    if (self.rightPuppets.count == self.leftPuppets.count ) {
        for (int i = 0; i < self.rightPuppets.count; i++) {
            if ( [[self.rightPuppets objectAtIndex:i] intValue] != [[self.leftPuppets objectAtIndex:i] intValue]) {
                isSymmetric = false;
            }
        }
    }else{
        isSymmetric = false;
    }
    if (self.rightPuppets.count < 4 ) {
        isSymmetric = false;
    }
    
    [self showResult:isSymmetric];
    NSLog(@"symmetric is %d", isSymmetric);
}

// present AnswersViewController 
- (void)showResult:(Boolean)isSymmetric{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSNumber *boolSymmetric = [NSNumber numberWithBool:isSymmetric];
    [userDefault setObject:boolSymmetric forKey:@"isSymmetric"];
    NSString *answerType = @"SymmetricView";
    [userDefault setObject:answerType forKey:@"Theme"];
    AnswersViewController *answerView = [[self storyboard ] instantiateViewControllerWithIdentifier:@"AnswersViewController" ];
   
    if(answerView == nil){
        NSLog(@"mathsView in modal view show is nil");
    }
    	// Create the navigation controller and present it modally.
    [answerView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	[self.navigationController pushViewController:answerView animated:YES];
}

// back to home page by present RootViewController
- (IBAction)backHome:(id)sender {
    
    RootViewController *rootView = [[self storyboard ] instantiateViewControllerWithIdentifier:@"RootViewController" ];
    if( rootView == nil){
        NSLog(@"rootView in modal view show is nil");
    }
    
	// Create the navigation controller and present it modally.
    [rootView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
	[self.navigationController pushViewController:rootView animated:YES];
}

#pragma mark init left and right puppet

/* arrangement of puppets
 - - - | - - - 
 1 2 3   3 2 1
 - - - | - - -
 4 5 6   6 5 4 
 - - - | - - -
 7 8 9   9 8 7 
 - - - | - - -
 */
// init puppet array which will show in view at the begining of a new game
// divide the screen to two parts, and each parts divided into 9 parts
// each size 80 * 45(width * length )

// init left puppet array with 4 to 7 puppets
- (void)initLeftPuppet{
//    get random numbe from 4 to 7
    int randomNumber = arc4random() % 3 + 4;
    self.leftPuppets = [self getNonRepeatArray:randomNumber];
    for (int i = 0; i < self.leftPuppets.count; i++) {
        NSLog(@"self.puppets is %@", [self.leftPuppets objectAtIndex:i]);
    }
}
// init right puppet base on value in self.leftPuppet
// if self.leftPuppet.count less than 5, add another puppet in the right
// else delete an puppet in the right
-(void)initRightPuppet{
    for (int i = 0; i < self.leftPuppets.count; i++) {
        [self.rightPuppets addObject:[self.leftPuppets objectAtIndex:i]];
    }
    NSLog(@"right puppet count: %d", self.rightPuppets.count);
   
    if (self.leftPuppets.count < 5 ) {
        int randomIndex = arc4random() % (self.restMatrix.count);
        [self.rightPuppets addObject:[self.restMatrix objectAtIndex:randomIndex]];
    }else{
        int randomIndex = arc4random() % (self.leftPuppets.count);
        [self.rightPuppets removeObjectAtIndex:randomIndex];
    }
    NSLog(@"sizeof left puppet and right puppet: %d, %d", self.leftPuppets.count, self.rightPuppets.count);
}
// return array with non repeat value
-(NSMutableArray*)getNonRepeatArray:(int)size{
    NSMutableArray *randArray = [[NSMutableArray alloc] init];
    NSMutableArray *matrix = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 9; i++) {
        [matrix addObject:[NSNumber numberWithInt:i]];
    }
    for (int i = 0; i < size; i++) {
        int matrixSize = matrix.count;
        int randIndex = arc4random() % matrixSize;
        NSNumber *value = [matrix objectAtIndex:randIndex];
        [randArray addObject:value];
        [matrix removeObjectAtIndex:randIndex];
    }
    self.restMatrix = matrix;
    return randArray;
}

// show puppet in view
-(void)showPuppet{
//    hidden all buttons at the beginning
    for( int i = 1; i <= 9; i ++ ){
        UIButton *leftbutton = (UIButton *)[self.view viewWithTag:60 + i];
        UIButton *rightbutton = (UIButton *)[self.view viewWithTag:50 + i];
        leftbutton.hidden = YES;
        rightbutton.hidden = YES;
    }
//    show left puppets base on indexs store in self.leftPuppet
    for (int i = 0; i < self.leftPuppets.count; i++) {
        int index = [[self.leftPuppets objectAtIndex:i] intValue];
        UIButton *button = (UIButton *)[self.view viewWithTag:60 + index];
        button.hidden = NO;
        [self jump:button];
//        [button addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:@"puppetview1.png"] forState:UIControlStateNormal];
    }
//    show left puppets base on indexs store in self.rightPuppet
    for (int i = 0; i < self.rightPuppets.count; i++) {
        int index = [[self.rightPuppets objectAtIndex:i] intValue];
        UIButton *button = (UIButton *)[self.view viewWithTag:50 + index];
        button.hidden = NO;
        [self jump:button];
//        [button addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:@"puppetview1.png"] forState:UIControlStateNormal];
    }
}

// animination of puppets jumpping
-(void)jump:(UIButton*)button{
    float times = 3.0f;
    int x = button.center.x;
    int y = button.center.y;
    
    float width = button.bounds.size.width;
    [UIView animateWithDuration:0.2f
                          delay:0.2f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         button.alpha = 1;
                         [UIView setAnimationRepeatCount:times];
                         [UIView setAnimationRepeatAutoreverses:YES];
                         
                         CGPoint center = CGPointMake(x-width/2, y);
                         if (button.center.y > center.y) {
                             button.center = center;
                             center.x += width/2;
                         }else{
                             button.center = center;
                             center.x -= width/2;
                         }
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             [UIView animateWithDuration:0.2 delay:0.0
                                                 options:UIViewAnimationOptionCurveEaseIn
                                              animations:^{
                                                 [button setCenter:CGPointMake(x, y)];
                                              }
                                              completion:nil];
                         }
                     }];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

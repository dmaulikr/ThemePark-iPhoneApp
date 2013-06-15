//
//  ShapViewController.h
//  ThemePark
//
//  Created by Ninglin Li on 6/9/13.
//  Copyright (c) 2013 Ninglin_Li. All rights reserved.

// 9 subview show in screen and user click each subview to change the
// subview's image to find out right answer, just like Jigsaw
// answer is one kind of geometry shape, like circle

#import <UIKit/UIKit.h>

@interface ShapeViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSMutableArray *indexArray;
@property (nonatomic) NSString *answerImage;


- (IBAction)submitAnswer:(id)sender;
- (IBAction)homePage:(id)sender;
- (IBAction)showInfo:(id)sender;


- (IBAction)changPhoto:(id)sender;

@end

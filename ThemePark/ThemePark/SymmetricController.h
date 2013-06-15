//
//  MathController.h
//  ThemePark
//
//  Created by Ninglin Li on 6/8/13.
//  Copyright (c) 2013 Ninglin_Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SymmetricController : UIViewController
@property (strong, nonatomic) NSMutableArray *leftPuppets;
@property (strong, nonatomic) NSMutableArray *rightPuppets;
@property (strong, nonatomic) NSMutableArray *restMatrix;

- (IBAction)deletePuppet:(id)sender;

- (IBAction)showInfo:(id)sender;

- (IBAction)uploadAnswer:(id)sender;

- (IBAction)backHome:(id)sender;
@end

//
//  ViewController.m
//  FPKitExamples
//
//  Created by Alvise Susmel on 25/09/2012.
//  Copyright (c) 2012 Fifty Pixels Ltd. All rights reserved.
//

#import "ViewController.h"
#import "FPNoInternetBar.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [FPNoInternetBar barWithHostname:nil destinationView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

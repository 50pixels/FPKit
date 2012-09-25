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
    bar = [FPNoInternetBar barWithHostname:nil destinationView:self.view];
    [bar retain];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [bar showBar];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [bar hideBar];
}
@end

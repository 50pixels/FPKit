//
//  FPNoInternetBar.m
//  FPKit
//
//  Created by Alvise Susmel on 25/09/2012.
//  Copyright (c) 2012 Fifty Pixels Ltd. All rights reserved.
//

#import "FPNoInternetBar.h"

@interface FPNoInternetBar(Private)
@end


@implementation FPNoInternetBar
@synthesize position = _position;

#pragma mark Memory management
-(void)dealloc
{
    [_hostname release];
    [super dealloc];
}

-(id)initWithHostname:(NSString*)hostname destinationView:(UIView*)destinationView
{
    self = [super initWithFrame:CGRectZero];
    if(self)
    {
        _destinationView = destinationView;
        _hostname = [hostname copy];
    }
    return self;
}


@end

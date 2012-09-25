//
//  FPKit.m
//  FPKit
//
//  Created by Alvise Susmel on 25/09/2012.
//  Copyright (c) 2012 Fifty Pixels Ltd. All rights reserved.
//

#import "FPKit.h"

@implementation FPKit

+(BOOL)isRetinaDisplay
{
    UIScreen *screen = [UIScreen mainScreen];
    if ([screen respondsToSelector:@selector(scale)]) {
        if(screen.scale == 2.0) return YES;
    }
    return NO;
}

@end

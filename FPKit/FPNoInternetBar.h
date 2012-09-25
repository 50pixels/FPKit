/*
 Copyright (c) 2012 Fifty Pixels Ltd.
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 */

//
//  FPNoInternetBar.h
//  FPKit
//
//  Created by Alvise Susmel on 25/09/2012.

#import <UIKit/UIKit.h>

typedef enum FPBarPosition {
    FPBarTop,
    FPBarBottom
} FPBarPosition;

@class  FPReachability;
@interface FPNoInternetBar : UIView
{
    UIView *_destinationView;
    NSString *_hostname;
    
    FPReachability *_reach;

    UIImageView *_backgroundImageView;
    UIImageView *_warningImageView;
    UILabel *_textLabel;
}
@property(nonatomic,readonly) BOOL reachable;
@property(nonatomic,assign) FPBarPosition position;

/** @brief Initialize the bar before starting monitoring internet status.
 ** @brief The bar will be placed as hidden on the destination view and will be visible only during connection error.
 ** @param hostname the destination hostname where the reachability tests will be done to.
 ** @param destination View where the bar will be shown. The object will NOT be retained.
 **/
-(id)initWithHostname:(NSString*)hostname destinationView:(UIView*)destinationView;

+(FPNoInternetBar*)barWithHostname:(NSString*)hostname destinationView:(UIView*)destinationView;

/** @brief Start monitoring internet status. When internet will be available, the bar will be hidden.
 **        When the hostname will be not reachable, then the bar will be displayed with slide down or slide up animation.
 **/
-(void)startMonitoring;
-(void)stopMonitoring;

@end

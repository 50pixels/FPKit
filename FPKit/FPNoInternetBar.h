//
//  FPNoInternetBar.h
//  FPKit
//
//  Created by Alvise Susmel on 25/09/2012.
//  Copyright (c) 2012 Fifty Pixels Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum FPBarPosition {
    FPBarTop,
    FPBarBottom
} FPBarPosition;

@interface FPNoInternetBar : UIView
{
    UIView *_destinationView;
    NSString *_hostname;
}

@property(nonatomic,assign) FPBarPosition position;

/** @brief Initialize the bar before starting monitoring internet status.
 ** @param hostname the destination hostname where the reachability tests will be done to.
 ** @param destination View where the bar will be shown. The object will NOT be retained.
 **/
-(id)initWithHostname:(NSString*)hostname destinationView:(UIView*)destinationView;



@end

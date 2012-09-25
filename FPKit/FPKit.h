//
//  FPKit.h
//  FPKit
//
//  Created by Alvise Susmel on 25/09/2012.
//  Copyright (c) 2012 Fifty Pixels Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPKit : NSObject
/** @brief Checks if the display is a retina display **/
+(BOOL)isRetinaDisplay;

/** @brief Useful to get images in bundle with automatic @2x if is retina **/
+(UIImage*)bundleImageNamed:(NSString*)imageName;

@end

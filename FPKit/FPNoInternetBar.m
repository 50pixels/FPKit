//
//  FPNoInternetBar.m
//  FPKit
//
//  Created by Alvise Susmel on 25/09/2012.
//  Copyright (c) 2012 Fifty Pixels Ltd. All rights reserved.
//

#import "FPNoInternetBar.h"
#import "Reachability.h"

@interface FPNoInternetBar(Private)
-(void)setupUI;

-(void)showBar;
-(void)hideBar;
@end


@implementation FPNoInternetBar
@synthesize position = _position;
@synthesize reachable = _reachable;
#pragma mark Memory management


-(void)dealloc
{
    [self stopMonitoring];
    [_hostname release];
    [super dealloc];
}

#pragma mark Initialize

+(FPNoInternetBar*)barWithHostname:(NSString*)hostname destinationView:(UIView*)destinationView
{
    FPNoInternetBar *bar = [[FPNoInternetBar alloc] initWithHostname:hostname destinationView:destinationView];
    [bar startMonitoring];
    return [bar autorelease];
}


-(id)initWithHostname:(NSString*)hostname destinationView:(UIView*)destinationView
{
    self = [super initWithFrame:CGRectZero];
    if(self)
    {
        _destinationView = destinationView;
        _hostname = [hostname copy];
        if(_hostname == nil)
        {
            _hostname = @"www.google.com";
        }
        [_destinationView addSubview:self];
        [self setHidden:YES];
    }
    return self;
}

-(void)stopMonitoring
{
    [_reach stopNotifier];
    [_reach release]; _reach=nil;
}

-(void)startMonitoring
{
    [self stopMonitoring];
    _reach = [[Reachability reachabilityWithHostname:_hostname] retain];
    _reach.reachableBlock = ^(Reachability*reach){
        _reachable = YES;

        if([NSThread isMainThread] == NO)
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideBar];
            });

        else [self hideBar];
            
    };
    
    _reach.unreachableBlock = ^(Reachability*reach){
        _reachable = NO;
        if([NSThread isMainThread] == NO)
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showBar];
            });
        
        else [self showBar];
    };
    [_reach startNotifier];
}

#pragma mark Bar UI
-(CGFloat)barHeight
{
    return 40.0;
}

-(CGFloat)barWidth
{
    //width is the same as the with of the destination view
    return _destinationView.frame.size.width;
}

-(void)setupUI
{
    self.backgroundColor = [UIColor redColor];
}


#pragma mark Reachability states

-(void)showBar
{
    //avoid if already shown
    if(!self.hidden) return;

    [_destinationView bringSubviewToFront:self];

    //the bar will be shown
    CGRect bf;
    bf.size = CGSizeMake([self barWidth], [self barHeight]);
    //at first I'm positioning the view outside

    //TOP (outside)
    if(self.position == FPBarTop)
        bf.origin = CGPointMake(0, -bf.size.height);
    //BOTTOM (outside)
    else bf.origin = CGPointMake(0, bf.size.height);
    self.frame = bf;
    
    [self setupUI];
    self.hidden = NO;
    
    //show animation
    bf.origin.y = self.position == FPBarTop ? 0.0 : _destinationView.frame.size.height - bf.size.height;
    [UIView animateWithDuration:0.4 animations:^{
        self.frame = bf;
    }];
}


-(void)hideBar
{
    //avoid if already hidden
    if(self.hidden) return;

    //the bar will be hidden
    CGRect bf;
    bf.size = CGSizeMake([self barWidth], [self barHeight]);

    
    //hide animation

    //TOP (outside)
    if(self.position == FPBarTop)
        bf.origin = CGPointMake(0, -bf.size.height);
    //BOTTOM (outside)
    else bf.origin = CGPointMake(0, bf.size.height);

    [UIView animateWithDuration:0.4 animations:^{
        self.frame = bf;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    

}

@end

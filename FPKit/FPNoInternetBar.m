//
//  FPNoInternetBar.m
//  FPKit
//
//  Created by Alvise Susmel on 25/09/2012.
//  Copyright (c) 2012 Fifty Pixels Ltd. All rights reserved.
//

#import "FPNoInternetBar.h"
#import "FPReachability.h"

#import "FPKit.h"

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
    [_backgroundImageView release];
    [_warningImageView release];
    [_textLabel release];
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
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.text = NSLocalizedString(@"No Internet Connection", nil); //default message
        
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _warningImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fp_warning.png"]];
        
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        _warningImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_backgroundImageView];
        [self addSubview:_textLabel];
        [self addSubview:_warningImageView];
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
    _reach = [[FPReachability reachabilityWithHostname:_hostname] retain];
    _reach.reachableBlock = ^(FPReachability*reach){
        _reachable = YES;

        if([NSThread isMainThread] == NO)
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideBar];
            });

        else [self hideBar];
            
    };
    
    _reach.unreachableBlock = ^(FPReachability*reach){
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

-(UIImage*)barBackgroundImage
{
    return [UIImage imageNamed:@"fp_bar_red_background.png"];
}



-(void)setupUI
{
    self.alpha = 0.8;

    self.backgroundColor = [UIColor redColor];
    _backgroundImageView.image = [self barBackgroundImage];
    _backgroundImageView.frame = self.bounds;
    
    _textLabel.backgroundColor = [UIColor clearColor];
    _textLabel.textColor = [UIColor whiteColor];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    _textLabel.shadowColor = [UIColor lightGrayColor];
    _textLabel.shadowOffset = CGSizeMake(0, -1);
    
    CGRect tlf = self.bounds;
    tlf.origin.x = 64;
    tlf.size.width -= 64;
    _textLabel.frame = tlf;
    
    CGRect wif;
    wif.size = CGSizeMake(24, 19);
    wif.origin.x = 32;
    wif.origin.y = (tlf.size.height - wif.size.height)/2.0;
    _warningImageView.frame = wif;
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

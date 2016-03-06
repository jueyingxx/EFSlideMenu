//
//  EFSlideManager.m
//  EFSlideMenu
//
//  Created by Jueying on 16/3/6.
//  Copyright © 2016年 Jueying. All rights reserved.
//

#import "EFSlideManager.h"

#define kOpenMaxRatio   0.7
#define Screen_Width    [[UIScreen mainScreen] bounds].size.width

@interface EFSlideManager ()

@property (nonatomic, strong) UIViewController *menuViewController;
@property (nonatomic, strong) UIViewController *mainViewController;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) UIView *snapView;
@property (nonatomic, assign) BOOL opened;

@end

@implementation EFSlideManager

+ (instancetype)sharedManager {
    static EFSlideManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)configMenuViewController:(UIViewController *)menuViewController mainViewController:(UIViewController *)mainViewController {
    if (menuViewController == nil || mainViewController == nil) {
        @throw [NSException exceptionWithName:@"EFSliderMenuExceprion" reason:@"SlideMenu's menuViewController or mainViewController can not be nil" userInfo:nil];
    }
    self.menuViewController = menuViewController;
    self.mainViewController = mainViewController;
    
    [self.mainViewController.view addSubview:self.menuViewController.view];
    
    if (self.slideDirection == EFSlideDirectionLeft) {
        self.menuViewController.view.frame = CGRectOffset([[UIScreen mainScreen] bounds],
            -Screen_Width, 0);
    } else {
        self.menuViewController.view.frame = CGRectOffset([[UIScreen mainScreen] bounds],Screen_Width, 0);
    }
}

- (void)openOrClose {
    if (self.opened) {
        [self close];
    } else {
        [self open];
    }
}

#pragma mark - Private

- (instancetype)init {
    self = [super init];
    if (self) {
        _slideType = EFSlideTypeBothMove;
        _slideDirection = EFSlideDirectionLeft;
        _opened = NO;
    }
    return self;
}

- (void)open {
    self.opened = YES;
    
    CGRect mainFrame = self.mainViewController.view.frame;
    CGRect menuFrame = self.menuViewController.view.frame;
   
    if (self.slideType == EFSlideTypeBothMove) {
        if (self.slideDirection == EFSlideDirectionLeft) {
            mainFrame.origin.x = kOpenMaxRatio * Screen_Width;
        } else {
            mainFrame.origin.x = -kOpenMaxRatio * Screen_Width;
        }
    } else {}
    
    if (self.slideDirection == EFSlideDirectionLeft) {
        menuFrame.origin.x = -(1 - kOpenMaxRatio) * Screen_Width;
    } else {
        menuFrame.origin.x = (1 - kOpenMaxRatio) * Screen_Width;
    }
    
    self.snapView = [self.mainViewController.view snapshotViewAfterScreenUpdates:NO];
    self.snapView.frame = self.mainViewController.view.frame;
    [self.mainViewController.view addSubview:self.snapView];
    
    if (self.slideType == EFSlideTypeBothMove) {
    } else {
        [self.mainViewController.view insertSubview:self.menuViewController.view aboveSubview:self.snapView];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.snapView.frame = mainFrame;
        self.menuViewController.view.frame = menuFrame;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.snapView addGestureRecognizer:self.tap];
        }
    }];
}

- (void)close {
    self.opened = NO;
    
    CGRect menuFrame = self.menuViewController.view.frame;
   
    if (self.slideDirection == EFSlideDirectionLeft) {
        menuFrame.origin.x = -Screen_Width;
    } else {
        menuFrame.origin.x = Screen_Width;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.menuViewController.view.frame = menuFrame;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.snapView removeFromSuperview];
        }
    }];
}

#pragma mark - actions

- (void)close:(UITapGestureRecognizer *)tap {
    [self close];
}

#pragma mark - setter 

- (void)setSlideType:(EFSlideType)slideType {
    _slideType = slideType;
}

- (void)setSlideDirection:(EFSlideDirection)slideDirection {
    _slideDirection = slideDirection;
    if (_slideDirection == EFSlideDirectionLeft) {
        self.menuViewController.view.frame = CGRectOffset([[UIScreen mainScreen] bounds],
                                                          -Screen_Width, 0);
    } else {
        self.menuViewController.view.frame = CGRectOffset([[UIScreen mainScreen] bounds],Screen_Width, 0);
    }
}


#pragma mark - getter

- (UITapGestureRecognizer *)tap {
    if (_tap == nil) {
        _tap = ({
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close:)];
            tap;
        });
    }
    return _tap;
}

@end

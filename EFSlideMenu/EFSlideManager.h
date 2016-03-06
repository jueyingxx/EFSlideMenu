//
//  EFSlideManager.h
//  EFSlideMenu
//
//  Created by Jueying on 16/3/6.
//  Copyright © 2016年 Jueying. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EFSlideType) {
    EFSlideTypeBothMove,
    EFSlideTypeMenuMove
};

typedef NS_ENUM(NSInteger, EFSlideDirection) {
    EFSlideDirectionLeft,
    EFSlideDirectionRight
};

@interface EFSlideManager : NSObject

@property (nonatomic, assign) EFSlideType slideType; // default is EFSlideTypeBothMove.
@property (nonatomic, assign) EFSlideDirection slideDirection; // default is EFSlideDirectionLeft.

+ (instancetype)sharedManager;

- (void)configMenuViewController:(UIViewController *)menuViewController mainViewController:(UIViewController *)mainViewController;
- (void)openOrClose;

@end

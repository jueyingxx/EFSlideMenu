//
//  EFHomeViewController.m
//  EFSlideMenu
//
//  Created by Jueying on 16/3/6.
//  Copyright © 2016年 Jueying. All rights reserved.
//

#import "EFHomeViewController.h"
#import "EFSlideManager.h"

@implementation EFHomeViewController
- (IBAction)right:(id)sender {
    [EFSlideManager sharedManager].slideDirection = EFSlideDirectionRight;
    [[EFSlideManager sharedManager] openOrClose];
}

- (IBAction)left:(id)sender {
    [EFSlideManager sharedManager].slideDirection = EFSlideDirectionLeft;
    [[EFSlideManager sharedManager] openOrClose];
}

@end

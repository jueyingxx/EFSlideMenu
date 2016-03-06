//
//  EFMainViewController.m
//  EFSlideMenu
//
//  Created by Jueying on 16/3/6.
//  Copyright © 2016年 Jueying. All rights reserved.
//

#import "EFMainViewController.h"
#import "EFSlideManager.h"

@implementation EFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController *menuViewController = [[UIViewController alloc] init];
    menuViewController.view.backgroundColor = [UIColor redColor];
    [[EFSlideManager sharedManager] configMenuViewController:menuViewController mainViewController:self];
    [EFSlideManager sharedManager].slideType = EFSlideTypeBothMove;
}

@end

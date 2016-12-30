//
//  ViewController.m
//  BreadCrumbNavigation
//
//  Created by Michael on 22/12/2016.
//  Copyright © 2016 Michael. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"
#import "DTNavigationController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"卓望";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setBarTintColor: [UIColor colorWithRed:26/255.0f green:193/255.0f blue:86/255.0f alpha:1]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIView *view = [self.navigationController.view viewWithTag:1998];
    [view removeFromSuperview];
    DTFolderBar *folderBar = [self.navigationController.view viewWithTag:1999];
    [folderBar removeFromSuperview];
}

- (IBAction)didTapPush:(UIButton *)sender {
    DemoViewController *vc = [[DemoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end

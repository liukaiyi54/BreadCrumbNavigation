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
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)didTapPush:(UIButton *)sender {
    DemoViewController *vc = [[DemoViewController alloc] init];
    DTFolderBarStyle style = DTFolderBarStyleNormal;
    DTNavigationController *navigation = [DTNavigationController navigationWithRootViewController:vc folderStyle:style];
    
    // make present animate like push
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self presentViewController:navigation animated:NO completion:nil];
}


@end

//
//  DEMONavigationController.m
//  BreadCrumbNavigation
//
//  Created by Michael on 30/12/2016.
//  Copyright © 2016 Michael. All rights reserved.
//

#import "DEMONavigationController.h"
#import "DTFolderBar.h"
#import "DTFolderItem.h"
#import "DTFolderConfig.h"

@interface DEMONavigationController (){
    UIView *blockView;
    DTFolderBar *_folderBar;
}
@property (nonatomic, strong) NSMutableArray *folderItems;

@end

@implementation DEMONavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Override
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    
    if (!blockView) {
        blockView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    }
    [blockView setBackgroundColor:[UIColor colorWithRed:26/255.0f green:193/255.0f blue:86/255.0f alpha:1]];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-40, 20, 80, 40)];
    label.text = @"卓望集团";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [blockView addSubview:label];
    [blockView setTag:1998];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 25, 40, 30)];
    [button setImage:[UIImage imageNamed:@"nav_back_btn_selected"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didTapBack) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [blockView addSubview:button];
    
    [self.view addSubview:blockView];
    
    if (!_folderBar) {
        CGRect frame = CGRectMake(0, 64, self.view.frame.size.width, 40);
        _folderBar = [DTFolderBar folderBarWithFrame:frame style:DTFolderBarStyleNormal];
        [_folderBar setTag:1999];
    }
    [self.view addSubview:_folderBar];
    
    DTFolderItem *folderItem = nil;
    NSMutableArray *folderItems = [NSMutableArray arrayWithArray:_folderBar.folderItems];
    if (viewController.title == nil) {
        folderItem = [DTFolderItem itemWithFolderName:@"first" targer:self action:@selector(tapFolderItem:)];
        folderItem.hideArrowForFirstItem = YES;
    } else {
        folderItem = [DTFolderItem itemWithFolderName:viewController.title targer:self action:@selector(tapFolderItem:)];
        [folderItem.textLable setTextColor:kFolderItemTextColor];
    }
    [folderItems addObject:folderItem];
    [_folderBar setFolderItems:folderItems animated:YES];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    NSMutableArray *folderItems = [NSMutableArray arrayWithArray:_folderBar.folderItems];
    [folderItems removeLastObject];
    
    [_folderBar setFolderItems:folderItems animated:NO];
    
    return [super popViewControllerAnimated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    NSMutableArray *folderItems = [NSMutableArray arrayWithArray:_folderBar.folderItems];
    
    //NSRange range = NSMakeRange(1, folderItems.count - 1);
    //[folderItems removeObjectsInRange:range];
    [folderItems removeAllObjects];
    
    [_folderBar setFolderItems:folderItems animated:YES];
    
    return [super popToRootViewControllerAnimated:YES];
}

- (void)tapFolderItem:(DTFolderItem *)sender {
    [sender setHightlighted:YES];
    
    NSMutableArray *folderItems = [NSMutableArray arrayWithArray:_folderBar.folderItems];
    
    if (sender == folderItems.lastObject) {
        return;
    }
    
    NSUInteger index = [folderItems indexOfObject:sender];
    
    if (index == NSNotFound) {
        return;
    }
    
    NSRange range = NSMakeRange(index + 1, folderItems.count - (index + 1));
    
    [folderItems removeObjectsInRange:range];
    
    [_folderBar setFolderItems:folderItems animated:YES];
    
    UIViewController *viewComtroller = [self.viewControllers objectAtIndex:index+1];  //因为开头加了个默认的，所以index要+1
    
    [self popToViewController:viewComtroller animated:YES];
}

- (void)didTapBack {
    [self popToRootViewControllerAnimated:YES];
}

@end

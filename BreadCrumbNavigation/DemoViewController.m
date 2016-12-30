//
//  DemoViewController.m
//  BreadCrumbNavigation
//
//  Created by Michael on 22/12/2016.
//  Copyright © 2016 Michael. All rights reserved.
//

#import "DemoViewController.h"
#import "DTNavigationController.h"
#import "DTFolderConfig.h"

@interface DemoViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"卓望集团";
    
    self.navigationItem.hidesBackButton = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"卓望集团";
    } else {
        cell.textLabel.text = @"卓望公司";
    }
    
    return cell;
}

#pragma mark - Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DemoViewController *vc = [[DemoViewController alloc] init];
    
    if (indexPath.row == 0) {
        vc.title = @"卓望集团";
    } else {
        vc.title = @"卓望公司";
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end

//
//  JYSBaseTableViewController.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/3.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSBaseTableViewController.h"
#import <RDVTabBar.h>
#import <RDVTabBarController.h>
#import <RDVTabBarItem.h>

#import "JYSOneImageTableViewCell.h"
#import "JYSOneBigImageTableViewCell.h"
#import "JYSImagesTableViewCell.h"
#import "JYSlistenTableViewCell.h"
#import "JYSCityNormalTableViewCell.h"
#import "JYSTalkTableViewCell.h"

@interface JYSBaseTableViewController ()

@end

@implementation JYSBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[JYSOneImageTableViewCell class] forCellReuseIdentifier:NEWSONEIMAGECELL];
    
    [self.tableView  registerClass:[JYSOneImageTableViewCell class] forCellReuseIdentifier:NEWSONEIMAGECELLSPECIAL];
   
    [self.tableView registerClass:[JYSOneBigImageTableViewCell class] forCellReuseIdentifier:NEWSONEBIGIMAGECELL];
    
    [self.tableView registerClass:[JYSImagesTableViewCell class] forCellReuseIdentifier:NEWSIMAGESCELL];

    [self.tableView registerClass:[JYSlistenTableViewCell class] forCellReuseIdentifier:LISTENCELL];
    
    [self.tableView registerClass:[JYSCityNormalTableViewCell class] forCellReuseIdentifier: CITYIMAGE];
    
    [self.tableView registerClass:[JYSCityNormalTableViewCell class] forCellReuseIdentifier:CITYNORMAL];
    
    [self.tableView registerClass:[JYSTalkTableViewCell class] forCellReuseIdentifier:TALKCELL];
    
    self.tableView.tableFooterView = [UIView new];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    [self.rdv_tabBarController setTabBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0 * M_PI) / 180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0 / -600;
    
    cell.layer.shadowColor = [[UIColor blackColor] CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    cell.layer.transform = rotation;
    //        CGPoint oldAnchorPoint = cell.layer.anchorPoint;
    //        cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
}

-(BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    return YES;
}
@end

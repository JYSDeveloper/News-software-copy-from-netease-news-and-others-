//
//  JYSMainTabBarController.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/3.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSMainTabBarController.h"
#import "JYSContainerViewController.h"
#import "JYSListenTableViewController.h"
#import "JYSLeftListTableViewController.h"
#import <MMDrawerController.h>
#import "JYSBaseNavigationController.h"
#import "JYSLocationNewsTableViewController.h"
#import "JYSCitysTableViewController.h"
#import "JYSTalkTableViewController.h"
@interface JYSMainTabBarController ()

@property(nonatomic,strong)MMDrawerController *listenDrawer;

@property(nonatomic,strong)MMDrawerController *locationDrawer;

@end

@implementation JYSMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTableController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupTableController{
    //资讯VC
    JYSContainerViewController *containerVC = [[JYSContainerViewController alloc]init];
    JYSBaseNavigationController *containerNav = [[JYSBaseNavigationController alloc]initWithRootViewController:containerVC];
   
    //听闻抽屉VC
    JYSListenTableViewController *listenVC = [[JYSListenTableViewController alloc]init];
    JYSLeftListTableViewController *leftListVC = [[JYSLeftListTableViewController alloc]init];
    JYSBaseNavigationController *listenNav = [[JYSBaseNavigationController alloc]initWithRootViewController:listenVC];
    self.listenDrawer = [[MMDrawerController alloc]initWithCenterViewController:listenNav leftDrawerViewController:leftListVC];
   
    //City
    JYSLocationNewsTableViewController *locationVC = [[JYSLocationNewsTableViewController alloc]init];
    JYSCitysTableViewController *citysVC = [[JYSCitysTableViewController alloc]init];
    JYSBaseNavigationController *locationNav = [[JYSBaseNavigationController alloc]initWithRootViewController:locationVC];
    self.locationDrawer = [[MMDrawerController alloc]initWithCenterViewController:locationNav rightDrawerViewController:citysVC];
    
    //talk
    JYSTalkTableViewController *talkVC = [[JYSTalkTableViewController alloc]init];
    JYSBaseNavigationController *talkNav = [[JYSBaseNavigationController alloc]initWithRootViewController:talkVC];
    
    [self setViewControllers:@[containerNav,self.listenDrawer,self.locationDrawer,talkNav]];
    
    NSArray *tabBarItemImages = @[@"news",@"listen",@"city",@"talk"];
    NSArray *tabBarItemTitles = @[@"资讯",@"听闻",@"本地",@"话题"];
    
    RDVTabBar *tabBar = [self tabBar];
    [tabBar setFrame:CGRectMake(CGRectGetMinX(tabBar.frame), CGRectGetMinY(tabBar.frame), CGRectGetWidth(tabBar.frame), 60)];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar]items]) {
        UIImage *normalImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",tabBarItemImages[index]]];
        UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",tabBarItemImages[index]]];
        [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:normalImage];
        [item setTitle:tabBarItemTitles[index]];
        index++;
    }
}



@end

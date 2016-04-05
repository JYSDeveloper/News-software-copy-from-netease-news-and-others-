//
//  JYSDaysNewsTableViewController.m
//  IngeniousNews
//
//  Created by 姜雨生 on 16/2/27.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSDaysNewsTableViewController.h"
#import "JYSNetWorkTools.h"
#import "JYSOneImageTableViewCell.h"
#import "JYSWebViewController.h"
#import "JYSOneBigImageTableViewCell.h"
#import "JYSNewsModel.h"
#import "JYSImagesTableViewCell.h"
#import "JYSImageShowViewController.h"
#import "JYSSpecialTableViewController.h"
@interface JYSDaysNewsTableViewController ()

@property(nonatomic,retain)NSMutableArray *dataModelArr;


@end

@implementation JYSDaysNewsTableViewController

-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"24小时要闻";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [JYSNetWorkTools NetWork_GetDaysNewsInfoResult:^(NSMutableArray *arr) {
        self.dataModelArr = arr;
        [self.tableView reloadData];
    }];
    [self.tableView registerClass:[JYSOneImageTableViewCell class] forCellReuseIdentifier:@"OneImageCell"];
    [self.tableView registerClass:[JYSOneBigImageTableViewCell class] forCellReuseIdentifier:@"OneBigImageCell"];
    [self.tableView registerClass:[JYSOneImageTableViewCell class] forCellReuseIdentifier:@"OneImageCellSpecial"];
    [self.tableView registerClass:[JYSImagesTableViewCell class] forCellReuseIdentifier:@"ImagesCell"];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, 49)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYSNewsModel *model = self.dataModelArr[indexPath.row];
    if (indexPath.row == 0) {
        JYSOneBigImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OneBigImageCell" forIndexPath:indexPath];
        [cell getDataWithModel:model];
        return cell;
    }
    else if([model.skipType  isEqual: @"special"]){
        
        JYSOneImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OneImageCellSpecial"];
        [cell getDataWithModel:model];
        return cell;
        
    }
    else if(model.imgextra){
        
        JYSImagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImagesCell"];
        [cell getDataWithModel:model];
        return cell;
    }

    else{
        JYSOneImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OneImageCell" forIndexPath:indexPath];
        [cell getDataWithModel:model];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JYSNewsModel *model = self.dataModelArr[indexPath.row];
    if (indexPath.row == 0) {
        
        return ONEBIGIMAGECELLHEIGHT;
    }
    else if (model.imgextra){
        return IMAGESCELLHEIGHT;
    }
    else{
        return ONEIMAGECELLHEIGHT;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JYSNewsModel *model = self.dataModelArr[indexPath.row];
    if (model.imgextra) {
        JYSImageShowViewController *imagesVC = [JYSImageShowViewController new];
        imagesVC.model = model;
        [self.navigationController pushViewController:imagesVC animated:YES];
    }
    else if (model.skipType){
        
        JYSSpecialTableViewController *specialVC = [JYSSpecialTableViewController new];
        specialVC.model = model;
        [self.navigationController pushViewController:specialVC animated:YES];
        
    }
    else{
    JYSWebViewController *web = [JYSWebViewController new];
    web.model = model;
    [self.navigationController pushViewController:web animated:YES];
    }
    
    
    
}



@end

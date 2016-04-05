//
//  JYSNewsTableViewController.m
//  IngeniousNews
//
//  Created by 姜雨生 on 16/2/27.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSNewsTableViewController.h"
#import "MHNetWorkTask.h"
#import "JYSNewsModel.h"
#import <MJRefresh.h>
#import "JYSWebViewController.h"
#import "JYSImageShowViewController.h"
#import "JYSSpecialTableViewController.h"
#import "JYSCellFactory.h"
#import "JYSLiveTableViewController.h"
@interface JYSNewsTableViewController ()

/** 数据数组*/
@property(nonatomic,retain)NSMutableArray *dataModelArr;
/** 界面数据计数器*/
@property(nonatomic,assign)NSInteger count;
/** 轮播图*/
@property(nonatomic,retain)UIScrollView *headView;
/** 透视图图片数组*/
@property(nonatomic,retain)NSArray *headViewImagesArr;

@end

@implementation JYSNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 1;
    self.dataModelArr = [NSMutableArray new];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadDataInfo)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(newDataInfo)];
    [self.tableView.mj_header beginRefreshing];

}

-(void)creatheadView{
    
    self.headView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, 200)];
    JYSNewsModel *model = [self.dataModelArr firstObject];
    self.headView.pagingEnabled = YES;
    self.headViewImagesArr = model.ads;
    self.headView.contentSize = CGSizeMake(UISCREENWIDTH * self.headViewImagesArr.count, 0);
    for (int i = 0; i<self.headViewImagesArr.count; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH*i, 0, UISCREENWIDTH, 200)];
        [image sd_setImageWithURL:[NSURL URLWithString:self.headViewImagesArr[i][@"imgsrc"]] placeholderImage:nil];
        [self.headView addSubview:image];
    }
    
}

/** 刷新数据*/
-(void)newDataInfo{
    NSString *head = @"http://c.m.163.com/nc/article/";
    NSString *foot = [NSString stringWithFormat:@"/%ld-20.html",20*self.count];
    NSString *temp = [NSString stringWithFormat:@"%@%@%@",head,self.url,foot];
    [MHNetWorkTask getWithURL:temp withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        result = [result objectForKey:self.key];
        if (result == nil) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else{
        for (NSDictionary *dic in result) {
            JYSNewsModel *model = [JYSNewsModel newsModelWithDic:dic];
            [self.dataModelArr addObject:model];
            [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataModelArr.count-2 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        }
        [self.tableView.mj_footer endRefreshing];
        }
    } withFail:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
    self.count++;
}

/** 加载数据*/
-(void)reloadDataInfo{
    [self.dataModelArr removeAllObjects];
    [self.tableView reloadData];
    NSString *head = @"http://c.m.163.com/nc/article/";
    NSString *foot = @"/0-20.html";
    NSString *temp = [NSString stringWithFormat:@"%@%@%@",head,self.url,foot];
    [MHNetWorkTask getWithURL:temp withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        result = [result objectForKey:self.key];
        for (NSDictionary *dic in result) {
            JYSNewsModel *model = [JYSNewsModel newsModelWithDic:dic];
            [self.dataModelArr addObject:model];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        if (self.headView == nil) {
             [self creatheadView];
        }
        if (self.headViewImagesArr.count) {
            
            self.tableView.tableHeaderView = self.headView;
        }

    } withFail:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/** section count*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
/** rows in secion*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModelArr.count-1;
}
/** cell */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JYSNewsModel *model = self.dataModelArr[indexPath.row+1];
    return  [JYSCellFactory cellWithTableView:tableView Model:model IndexPath:indexPath];
}
/** cell hight*/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JYSNewsModel *model = self.dataModelArr[indexPath.row+1];
    return [JYSCellFactory cellHightWithModel:model];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JYSNewsModel *model = self.dataModelArr[indexPath.row+1];
    if ([model.skipType  isEqual: @"photoset"]) {
        JYSImageShowViewController *imagesVC = [JYSImageShowViewController new];
        imagesVC.model = model;
        [self.navigationController pushViewController:imagesVC animated:YES];
    }
    else if ([model.skipType isEqual:@"special"]){
        JYSSpecialTableViewController *specialVC = [JYSSpecialTableViewController new];
        specialVC.model = model;
        [self.navigationController pushViewController:specialVC animated:YES];
    }
    else{
    JYSWebViewController *web = [JYSWebViewController new];
    web.model = model;
    web.type = firstType;
    [self.navigationController pushViewController:web animated:YES];
    }
//    JYSLiveTableViewController *live = [JYSLiveTableViewController new];
//    [self.navigationController pushViewController:live animated:YES];
    
}

@end

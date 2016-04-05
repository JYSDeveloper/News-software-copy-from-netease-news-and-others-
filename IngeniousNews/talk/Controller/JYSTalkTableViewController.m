//
//  JYSTalkTableViewController.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/9.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSTalkTableViewController.h"
#import "JYSTalkTableViewCell.h"
#import "MHNetWorkTask.h"
#import "JYSTalkModel.h"
#import <MJRefresh.h>
#import "JYSTalkDetailTableViewController.h"

#warning 此界面典型反面教材，写得时候比较着急，脑袋短路了，请绝对不要参考，后续修复！！
@interface JYSTalkTableViewController ()

@property(nonatomic,retain)NSMutableArray *dataArr;

@property(nonatomic,assign)NSInteger count;

@end

@implementation JYSTalkTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = [NSMutableArray new];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(newDataInfo)];
    [self.tableView.mj_header beginRefreshing];
    
}

-(void)newDataInfo{
    
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/newstopic/list/expert/%ld-10.html",self.count*10];
    [MHNetWorkTask getWithURL:url withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        result = result[@"data"][@"expertList"];
        for (NSDictionary *temp in result) {
            JYSTalkModel *model = [JYSTalkModel talkModelWithDic:temp];
            [self.dataArr addObject:model];
        }
        self.count++;
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];

    } withFail:^(NSError *error) {
        
    }];
}


-(void)getData{
    [self.dataArr removeAllObjects];
    [self.tableView reloadData];
    NSString *url = @"http://c.m.163.com/newstopic/list/expert/0-10.html";
    [MHNetWorkTask getWithURL:url withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        result = result[@"data"][@"expertList"];
        for (NSDictionary *temp in result) {
            JYSTalkModel *model = [JYSTalkModel talkModelWithDic:temp];
            [self.dataArr addObject:model];
        }
        self.count = 1;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } withFail:^(NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JYSTalkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TALKCELL];
    [cell getDataWithModel:self.dataArr[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return TALKCELLHEIGHT;
}

#warning 返回高度漏洞百出，不适合使用，典型的反面教材，请勿参考！！！！
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JYSTalkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TALKCELL];
    [cell getDataWithModel:self.dataArr[indexPath.row]];
    [cell layoutIfNeeded];
    return cell.involvementLable.frame.size.height+cell.involvementLable.frame.origin.y+20;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JYSTalkDetailTableViewController *detail = [JYSTalkDetailTableViewController new];
    detail.model = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
    
}

@end

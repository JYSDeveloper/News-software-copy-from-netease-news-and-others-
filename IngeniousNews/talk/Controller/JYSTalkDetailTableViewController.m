//
//  JYSTalkDetailTableViewController.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/9.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSTalkDetailTableViewController.h"
#import <UIImageView+WebCache.h>
#import "JYSNetWorkTools.h"
#import "JYSTalkDetailModel.h"
#import "JYSTalkDetailCell.h"
#import "JYSTalkDetailHeadView.h"
#import "JYSSectionView.h"
#import <MJRefresh.h>
@interface JYSTalkDetailTableViewController ()

@property(nonatomic,retain)UIImageView *titleImage;

@property(nonatomic,retain)UILabel *titileLable;

@property(nonatomic,retain)UILabel *titleViewLable;

@property(nonatomic,retain)NSMutableArray *hotRepeats;

@property(nonatomic,retain)NSMutableArray *lateRepeats;

@property(nonatomic,retain)JYSSectionView *sectionView;

@property(nonatomic,retain)NSMutableArray *tableData;
@end

@implementation JYSTalkDetailTableViewController

#warning 此界面典型反面教材，写得时候比较着急，脑袋短路了，请绝对不要参考，后续修复！

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.sectionView = [[JYSSectionView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, 30) Message:self.model];
    [self.sectionView.segment addTarget:self action:@selector(changeData:) forControlEvents:UIControlEventValueChanged];
    [JYSNetWorkTools NetWork_GetTalkInfoWithID:self.model.expertId Hot:^(NSMutableArray *hot, NSMutableArray *late) {
        self.hotRepeats = hot;
        self.lateRepeats = late;
        self.tableData = hot;
        [self.tableView reloadData];
    }];
    
    JYSTalkDetailHeadView *headView =[[JYSTalkDetailHeadView alloc]initWithFrame:CGRectMake(0, 200, UISCREENWIDTH, 0) Message:self.model];
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, 200+headView.frame.size.height)];
    [headerView addSubview:self.titleImage];
    [headerView addSubview:headView];
    self.tableView.tableHeaderView = headerView;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(newDataInfo)];
}
-(void)newDataInfo{
    
    if (self.sectionView.segment.selectedSegmentIndex == 0) {
        NSString *url = [NSString stringWithFormat:@"http://c.3g.163.com/newstopic/list/hotqa/%@/%ld-10.html",self.model.expertId,self.hotRepeats.count];
        [JYSNetWorkTools NetWork_GetTalkMessageWithURLString:url Block:^(NSMutableArray *result) {
            [self.hotRepeats addObjectsFromArray:result];
        }];
    }else{
        NSString *url = [NSString stringWithFormat:@"http://c.3g.163.com/newstopic/list/latestqa/%@/%ld-10.html",self.model.expertId,self.lateRepeats.count];
        [JYSNetWorkTools NetWork_GetTalkMessageWithURLString:url Block:^(NSMutableArray *result) {
            [self.lateRepeats addObjectsFromArray:result];
        }];
    }
    
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}
-(void)creatUI{
    
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, UISCREENWIDTH, 200)];
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:self.model.picurl] placeholderImage:nil];
    
    self.titileLable = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, UISCREENWIDTH-100, 60)];
    self.titileLable.text = self.model.alias;
    self.titileLable.textColor = [UIColor whiteColor];
    self.titileLable.font = [UIFont systemFontOfSize:20];
    self.titileLable.numberOfLines = 0;
    [self.titleImage addSubview:self.titileLable];
   // self.tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
   // [self.view insertSubview:self.titleImage atIndex:0];
    
    self.titleViewLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, 50)];
    self.titleViewLable.textColor = [UIColor blackColor];
    self.titleViewLable.text = self.model.alias;
    self.navigationItem.titleView = self.titleViewLable;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)changeData:(UISegmentedControl*)sender{
    
    if (sender.selectedSegmentIndex == 1) {
        self.tableData = self.lateRepeats;
    }
    else{
        self.tableData = self.hotRepeats;
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.sectionView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *ID = @"cell";
    JYSTalkDetailCell * cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil ) {
        cell = [[JYSTalkDetailCell alloc]initWithStyle:1 reuseIdentifier:ID];
    }
    [cell getDataWithModel:self.tableData[indexPath.row]];
    //  取消cell的点击效果,没有点击后的阴影
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
     
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JYSTalkDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
       cell = [[JYSTalkDetailCell alloc]initWithStyle:1 reuseIdentifier:@"cell"];
    }
    [cell getDataWithModel:self.tableData[indexPath.row]];
    return cell.answerView.frame.size.height + cell.questionView.frame.size.height+15;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}



-(BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    return YES;
}
@end

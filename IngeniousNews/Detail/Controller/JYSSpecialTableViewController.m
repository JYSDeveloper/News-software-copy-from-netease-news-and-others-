//
//  JYSSpecialTableViewController.m
//  IngeniousNews
//
//  Created by 姜雨生 on 16/3/1.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSSpecialTableViewController.h"
#import "MHNetWorkTask.h"
#import "JYSSpecialModel.h"
#import "JYSOneImageTableViewCell.h"
#import "JYSImagesTableViewCell.h"
#import "JYSImageShowViewController.h"
#import "JYSWebViewController.h"
#import "JYSLableCollectionViewCell.h"
#import "JYSCellFactory.h"
@interface JYSSpecialTableViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,retain)NSMutableArray *dataArr;

@property(nonatomic,retain)UICollectionView *titleView;


@end

@implementation JYSSpecialTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self dataInfo];
    

    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, 49)];
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.hidesBottomBarWhenPushed = YES;
}

/** 获取数据*/
-(void)dataInfo{
    
    self.dataArr = [NSMutableArray new];
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/special/%@.html",self.model.skipID];
    [MHNetWorkTask getWithURL:url withParameter:nil withHttpHeader:nil
             withResponseType:ResponseTypeJSON withSuccess:^(id result) {
                 result = [result objectForKey:self.model.skipID];
                 result = [result objectForKey:@"topics"];
                 for (NSDictionary *temp in result) {
                     JYSSpecialModel *model = [JYSSpecialModel specialModelWithDic:temp];
                     [self.dataArr addObject:model];
                 }
                 [self.tableView reloadData];
                 [self creatUI];
                 self.tableView.tableHeaderView = self.titleView;
             } withFail:^(NSError *error) {
             }];
    
   
}
/** 创建collectionView*/
-(void)creatUI{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //每个cell的大小
    flowLayout.itemSize = CGSizeMake((UISCREENWIDTH-50)/4, 25);
    //分区距离上下左右空白
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //两行之间的行距
    flowLayout.minimumLineSpacing = 5;
    //两个单元格之间的距离
    flowLayout.minimumInteritemSpacing = 10;
    if(self.dataArr.count%4){
    self.titleView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, (self.dataArr.count/4+1)*35+10) collectionViewLayout:flowLayout];
    }
    else{
        self.titleView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, (self.dataArr.count/4)*35) collectionViewLayout:flowLayout];
    }
    self.titleView.backgroundColor = [UIColor whiteColor];
    self.titleView.delegate = self;
    self.titleView.dataSource = self;
    [self.titleView registerClass:[JYSLableCollectionViewCell class] forCellWithReuseIdentifier:@"collectionItems"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - collection 代理方法

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArr.count;
    
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JYSSpecialModel *model = self.dataArr[indexPath.row];
    JYSLableCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionItems" forIndexPath:indexPath];
    cell.title.text = model.shortname;
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //调到对应的row的位置,头,尾,中间,无
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    JYSSpecialModel *model = self.dataArr[section];
    return model.news.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JYSSpecialModel *model = self.dataArr[indexPath.section];
    JYSNewsModel *newsModel = model.news[indexPath.row];
    return [JYSCellFactory cellWithTableView:tableView Model:newsModel IndexPath:indexPath];

    
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    JYSSpecialModel *model = self.dataArr[section];
    NSString *title = [NSString stringWithFormat:@"%ld/%ld\t%@",section+1,self.dataArr.count,model.tname];
    return title;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JYSSpecialModel *model = self.dataArr[indexPath.section];
    JYSNewsModel *newsModel = model.news[indexPath.row];
    return [JYSCellFactory cellHightWithModel:newsModel];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JYSSpecialModel *model = self.dataArr[indexPath.section];
    JYSNewsModel *newsModel = model.news[indexPath.row];
    if (newsModel.imgextra) {
        
        JYSImageShowViewController *imageShowVC = [JYSImageShowViewController new];
        imageShowVC.model = newsModel;
        [self.navigationController pushViewController:imageShowVC animated:YES];
    }
    else if(newsModel.skipID){
        
        JYSSpecialTableViewController *VC = [JYSSpecialTableViewController new];
        VC.model = newsModel;
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    else{
        JYSWebViewController *webViewVC = [JYSWebViewController new];
        webViewVC.model = newsModel;
        [self.navigationController pushViewController:webViewVC animated:YES];
        
    }
}


@end

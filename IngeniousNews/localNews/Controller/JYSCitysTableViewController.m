//
//  JYSCitysTableViewController.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/5.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSCitysTableViewController.h"
#import "JYSNetWorkTools.h"
#import "JYSCityMessageModel.h"
#import "JYSCityGroupModel.h"
@interface JYSCitysTableViewController ()

@property(nonatomic,retain)NSMutableArray *dataArr;

@end

@implementation JYSCitysTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [JYSNetWorkTools NetWork_GetCitysMessageResult:^(NSMutableArray *arr) {
        self.dataArr = arr;
        [self.tableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    JYSCityGroupModel *model = self.dataArr[section];
    
    return model.citys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:@"cell"];
    }
    JYSCityGroupModel *model = self.dataArr[indexPath.section];
    JYSCityMessageModel *childModel = model.citys[indexPath.row];
    cell.textLabel.text = childModel.name;
    // Configure the cell...
    
    return cell;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    JYSCityGroupModel *model = self.dataArr[section];
    return model.title;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JYSCityGroupModel *model = self.dataArr[indexPath.section];
    JYSCityMessageModel *childModel = model.citys[indexPath.row];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeCity" object:self userInfo:@{@"city":childModel.name,@"cityType":childModel.type}];
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSArray *arr = [NSArray array];
    for (JYSCityGroupModel *model in self.dataArr) {
        arr = [arr arrayByAddingObject:model.title];
    }
    return arr;
}


@end

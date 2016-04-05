//
//  JYSLocationNewsTableViewController.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/5.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSLocationNewsTableViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <UIViewController+MMDrawerController.h>
#import <MJRefresh.h>
#import "MHNetWorkTask.h"
#import "JYSCityNewsModel.h"
#import "JYSCellFactory.h"
#import "JYSCitysTableViewController.h"
#import "JYSCityMessageModel.h"
#import "JYSLocationWebViewController.h"

@interface JYSLocationNewsTableViewController ()<CLLocationManagerDelegate>

@property(nonatomic,retain)CLLocationManager *locationManager;

@property(nonatomic,copy)NSString *cityName;

@property(nonatomic,copy)NSString *cityType;

@property(nonatomic,retain)UILabel *cityLable;

@property(nonatomic,retain)NSMutableArray *dataArr;

@property(nonatomic,assign)NSUInteger count;

@end


@implementation JYSLocationNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSMutableArray new];
    
    self.navigationItem.title = @"本地新闻";
    [self rightBtn];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dataChange:) name:@"changeCity" object:nil];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getDataWithCity)];
    self.cityType = @"city";
    //self.cityName = @"北京";
    [self locate];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(newData)];

}

-(void)newData{
    
   NSString *url = [NSString stringWithFormat:@"http://api.irecommend.ifeng.com/local.php?choicename=%@&page=%ld&choicetype=%@",self.cityName,(unsigned long)self.count,self.cityType];
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [MHNetWorkTask getWithURL:url withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
            result = result[@"data"][@"list"][@"item"];
            for (NSDictionary *temp in result) {
                JYSCityNewsModel *model = [JYSCityNewsModel dataWithDic:temp];
                [self.dataArr addObject:model];
                [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataArr.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            }
           // [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        self.count++;
    } withFail:^(NSError *error) {
        
    }];
    
}

//通知执行函数
-(void)dataChange:(NSNotification*)sender{
    
    NSDictionary *dic = [sender userInfo];
    self.cityType = dic[@"cityType"];
    self.cityName = dic[@"city"];
}
//右按钮
-(void)rightBtn{
    
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    self.cityLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 30, 30)];
    self.cityLable.text = self.cityName;
    self.cityLable.font = [UIFont systemFontOfSize:12];
    [view addSubview:self.cityLable];
    UIImageView *location = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [location setImage:[UIImage imageNamed:@"location"]];
    [view addSubview:location];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeCity)]];
}
//右按钮执行函数
-(void)changeCity{
    
    [self.navigationController pushViewController:[JYSCitysTableViewController new] animated:YES];
}
//cityName懒加载
-(void)setCityName:(NSString *)cityName{
    
    if (!cityName) {
        cityName = @"北京";
    }
    _cityName = cityName;
    self.cityLable.text = _cityName;
    self.count = 2;
    [self.tableView.mj_header beginRefreshing];
}
//刷新数据
-(void)getDataWithCity{
    [self.dataArr removeAllObjects];
    [self.tableView reloadData];
    NSString *path = [NSString stringWithFormat:@"http://api.irecommend.ifeng.com/local.php?choicename=%@&choicetype=%@",self.cityName,self.cityType];
#warning 中文转UTF8码!!!
    path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [MHNetWorkTask getWithURL:path withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        if ([result objectForKey:@"success"]) {
        result = result[@"data"][@"list"][@"item"];
        for (NSDictionary *temp in result) {
            JYSCityNewsModel *model = [JYSCityNewsModel dataWithDic:temp];
            [self.dataArr addObject:model];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        }
        else{
            self.cityName = @"北京";
        }
        
    } withFail:^(NSError *error) {
        
    }];
    
}




//开始定位
-(void)locate{
    
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 10.0f;
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];
    }
    else{
        
        //提示用户无法定位!!!
        
    }
}

#pragma mark - CoreLocation Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //取最后一个位置,就是当前最新的位置信息
    CLLocation *currentLocation = [locations lastObject];
    //获取所在城市的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = [placemarks objectAtIndex:0];
            NSLog(@"具体位置:%@",placeMark.name);//具体位置!!!
            //位置对应的城市名
            NSString *city = placeMark.locality;
            if (!city) {
                //四大直辖市无法通过locality获取,只能通过对应的省来获取!!!
                city = placeMark.administrativeArea;
            }
            self.cityName = [city stringByReplacingOccurrencesOfString:@"市" withString:@""];
            NSLog(@"%@",self.cityName);
            [manager stopUpdatingLocation];
}
        else if (error == nil && [placemarks count] == 0){
            NSLog(@"No results were returned.");
        }
        else if (error != nil){
            NSLog(@"an error occurred = %@",error);
        }
    }];
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
    return self.dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JYSCityNewsModel *model = self.dataArr[indexPath.row];
    return  [JYSCellFactory cellWithTableView:tableView Model:model IndexPath:indexPath];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return LISTENCELLHEIGHT;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JYSCityNewsModel *model = self.dataArr[indexPath.row];
    JYSLocationWebViewController *webVC = [JYSLocationWebViewController new];
    webVC.model = model;
    [self.navigationController pushViewController:webVC animated:YES];
    
}


@end

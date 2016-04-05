//
//  JYSLeftListTableViewController.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/2.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSLeftListTableViewController.h"
#import <UIViewController+MMDrawerController.h>
@interface JYSLeftListTableViewController ()
@property(nonatomic,retain)NSArray *arrayList;
@end

@implementation JYSLeftListTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    //self.navigationController.navigationBarHidden = YES;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, 20)];
    view.backgroundColor = [UIColor colorWithWhite:0.439 alpha:1.000];
    self.tableView.tableHeaderView = view;
}
-(NSArray *)arrayList{
    if (_arrayList == nil) {
        _arrayList = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"ListenURLs.plist" ofType:nil]];
    }
    return _arrayList;
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
    return self.arrayList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.arrayList[indexPath.row][@"title"];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = 0;
    cell.backgroundColor = [UIColor colorWithWhite:0.439 alpha:1.000];
    cell.imageView.image = [UIImage imageNamed:self.arrayList[indexPath.row][@"image"]];
    // Configure the cell...
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    NSDictionary *dic = self.arrayList[indexPath.row];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeInfo" object:self userInfo:dic];
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

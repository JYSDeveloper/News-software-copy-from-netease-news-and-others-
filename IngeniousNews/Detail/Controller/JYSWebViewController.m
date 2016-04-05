//
//  JYSWebViewController.m
//  IngeniousNews
//
//  Created by 姜雨生 on 16/2/27.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSWebViewController.h"
#import "JYSWebViewImgModel.h"
#import "MHNetWorkTask.h"
#import "JYSBaseNavigationController.h"
@interface JYSWebViewController ()<UIWebViewDelegate>

@property(nonatomic,retain)UIWebView *webView;

@property(nonatomic,retain)JYSWebViewModel *webModel;

@end

@implementation JYSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    self.webView.delegate = self;
    
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.model.docid];
    NSLog(@"%@",url);
    [MHNetWorkTask getWithURL:url withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        self.webModel = [JYSWebViewModel webViewModelWithDic:result[self.model.docid]withType:self.type];
        if ([self.webModel.body rangeOfString:@"下载地址"].location != NSNotFound) {
            //NSLog(@"%ld",self.webModel.img.count);
            NSLog(@"%@",self.webModel.href);
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webModel.href]]];
        }
        else{
        [self showInWebView];
        }
    } withFail:^(NSError *error) {
        
    }];
    
    
   // self.tableView.tableHeaderView = self.webView;
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showInWebView
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"JYSDetails.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body>"];
    [html appendString:[self touchBody]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    [self.webView loadHTMLString:html baseURL:nil];
}

- (NSString *)touchBody
{
       NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.webModel.title];
    [body appendFormat:@"<div class=\"time\">%@</div>",self.webModel.ptime];
    if (self.webModel.body != nil) {
       // [body appendString:self.webModel.body];
        [body appendFormat:@"<div class=\"note\">%@</div>",self.webModel.body];
    }
  //   遍历img
    for (JYSWebViewImgModel *webImgModel in self.webModel.img) {
        NSMutableString *imgHtml = [NSMutableString string];
        
        // 设置img的div
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        
        // 数组存放被切割的像素
        NSArray *pixel = [webImgModel.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject]floatValue];
        CGFloat height = [[pixel lastObject]floatValue];
        // 判断是否超过最大宽度
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'sx:src=' +this.src;"
        "};";
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,webImgModel.src];
        // 结束标记
        [imgHtml appendString:@"</div>"];
//        // 替换标记
       [body replaceOccurrencesOfString:webImgModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;

}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 0;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 0;
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:1 reuseIdentifier:@"cell"];
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
//    return cell;
//    
//}

//-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    
//    CGFloat h = webView.scrollView.contentSize.height;
//    NSLog(@"%f",h);
//    self.webView.frame = CGRectMake(0, 0, UISCREENWIDTH, h+20);
//   self.tableView.tableHeaderView = self.webView;
//}

@end

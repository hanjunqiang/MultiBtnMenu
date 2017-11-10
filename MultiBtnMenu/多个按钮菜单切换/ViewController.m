//
//  ViewController.m
//  多个按钮菜单切换
//
//  Created by 韩军强 on 2017/11/7.
//  Copyright © 2017年 韩军强. All rights reserved.
//

#import "ViewController.h"
#import "JQDeuceMenu.h"

@interface ViewController ()

@end

@implementation ViewController

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /**
        图片显示不全的原因：
         1，要么图片尺寸不对
         2，要么frame设置的不对
         水平方向：frame_h
         竖直方向：frame_v
    */
    
    CGRect frame_h = {0, 100, SCREEN_WIDTH, 50};
    CGRect frame_v = {100, 200, 100, 120};
    
    //水平方向
    JQDeuceMenu *menuView1 = [[JQDeuceMenu alloc] jq_initWithFrame:frame_h imgNamesArray:[@[
                                                                                           @[@"news.jpg",@"news_hover.jpg"],
                                                                                           @[@"huodong.jpg",@"huodong_hover.jpg"],
                                                                                           @[@"tongzhi.jpg",@"tongzhi_hover.jpg"]
                                                                                           ] mutableCopy] lineHeight:2 click:^(NSInteger index) {
             NSLog(@"index---%zd",index);
    }];
    
    //竖直方向
    JQDeuceMenu *menuView2 = [[JQDeuceMenu alloc] jq_initWithFrame:frame_v stype:JQDeuceMenuVertical lineHeight:2 imgNamesArray:[@[
                                                                                                                                    @[@"news.jpg",@"news_hover.jpg"],
                                                                                                                                    @[@"huodong.jpg",@"huodong_hover.jpg"],
                                                                                                                                    @[@"tongzhi.jpg",@"tongzhi_hover.jpg"]
                                                                                                                                    ] mutableCopy]click:^(NSInteger index) {
        NSLog(@"index---%zd",index);

    }];
    
    menuView1.linelbl.backgroundColor = [UIColor redColor];
    menuView2.linelbl.backgroundColor = [UIColor blueColor];
    [self.view addSubview:menuView1];
    [self.view addSubview:menuView2];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

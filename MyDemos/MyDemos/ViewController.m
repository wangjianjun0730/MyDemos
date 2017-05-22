//
//  ViewController.m
//  MyDemos
//
//  Created by 平安科技 on 17/4/20.
//  Copyright © 2017年 wangjianjune. All rights reserved.
//

#import "ViewController.h"
#import "RSAEncryptorVC.h"
#import "ALViewController.h"
#import "FMDBTestVC.h"
#import "NSURLProtocolVC.h"
#import "CCodeTestVC.h"
#import "SwizzMethodVC.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *funcs;///<所有功能模块
@property (nonatomic, strong) UITableView *tableView;///<tableView

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self UIConfig];
}

- (void)UIConfig{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"" forKey:@"status"];
    
    
    
    self.funcs = @[@{@"title":@"RSA加密",@"methodName":@"rsa_viewControllerJump"},
                   @{@"title":@"支付宝",@"methodName":@"zifubao_viewControllerJump"},
                   @{@"title":@"FMDB测试",@"methodName":@"FMDB_viewControllerJump"},
                   @{@"title":@"NSURLProtocolDemo",@"methodName":@"NSURLProtocol_viewControllerJump"},
                   @{@"title":@"C代码测试",@"methodName":@"CCodeTest_viewControllerJump"},
                   @{@"title":@"NSURLProtocolDemo",@"methodName":@"NSURLProtocol_viewControllerJump"},
                   @{@"title":@"runtime交换方法实现",@"methodName":@"swizzMethod_viewControllerJump"}];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.funcs.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *titleStr = self.funcs[indexPath.row][@"title"];
    cell.textLabel.text = titleStr;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



#pragma mark - tableView数据源方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *selectStr = self.funcs[indexPath.row][@"methodName"];
    SEL selector = NSSelectorFromString(selectStr);
    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:selector];
    
    //这里不用设置参数
    //int a = 1;
    //int b = 2;
    //int c = 3;
    //[invocation setArgument:&a atIndex:2];
    //[invocation setArgument:&b atIndex:3];
    //[invocation setArgument:&c atIndex:4];
    //设置返回值(这里将c返回)
    //[invocation setReturnValue:&c];
    
    //获取返回值
    [invocation invoke];
}



#pragma mark - 功能跳转

/**
 RSA加密
 */
- (void)rsa_viewControllerJump{
    RSAEncryptorVC *vc = [[RSAEncryptorVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 支付宝
 */
- (void)zifubao_viewControllerJump{
    ALViewController *vc = [[ALViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 FMDB
 */
- (void)FMDB_viewControllerJump{
    FMDBTestVC *fmdb = [[FMDBTestVC alloc] init];
    [self.navigationController pushViewController:fmdb animated:YES];
}


/**
 NSURLProtocol
 */
- (void)NSURLProtocol_viewControllerJump{
    NSURLProtocolVC *protocol = [[NSURLProtocolVC alloc] init];
    [self.navigationController pushViewController:protocol animated:YES];
}


/**
 c代码测试
 */
- (void)CCodeTest_viewControllerJump{
    CCodeTestVC *ccode = [[CCodeTestVC alloc] init];
    [self.navigationController pushViewController:ccode animated:YES];
}


/**
 交换方法
 */
-(void)swizzMethod_viewControllerJump{
    
    SwizzMethodVC *swizz = [[SwizzMethodVC alloc] init];
    [self.navigationController pushViewController:swizz animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
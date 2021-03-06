//
//  YinDaoYeViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/9/12.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "YinDaoYeViewController.h"

#import "Header.h"

#import "ShouYeViewController.h"
#import "HuoDongViewController.h"
#import "WoViewController.h"
#import "CompanyViewController.h"

@interface YinDaoYeViewController () <UIScrollViewDelegate,UITabBarControllerDelegate> {
    NSInteger _index;
    UITabBarController *_tabBarC;
    NSArray *_arrayImageView;
    UIImageView *_imageViewLast;
}

@end

@implementation YinDaoYeViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _arrayImageView = @[@"6智造家APP-启动页1",@"6智造家APP-启动页2",@"6智造家APP-启动页3"];
    self.scrollView.contentSize = CGSizeMake(kMainW*3, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        if([UIViewController instancesRespondToSelector:@selector(edgesForExtendedLayout)]) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_arrayImageView[i]]];
        imageView.frame = CGRectMake(kMainW*i, 0, kMainW, kMainH);
        [self.scrollView addSubview:imageView];
        _imageViewLast = imageView;
    }
    _imageViewLast.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelector:)];
    [_imageViewLast addGestureRecognizer:tap];
}

- (void)tapSelector:(UITapGestureRecognizer *)tap {
    
    ShouYeViewController *shouyeVC = [[ShouYeViewController alloc] init];
    shouyeVC.tabBarItem.title = @"首页";
    shouyeVC.tabBarItem.image = [UIImage imageNamed:@"icon_home"];
    shouyeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_home_2t"];
    
    HuoDongViewController *huodongVC = [[HuoDongViewController alloc] init];
    huodongVC.tabBarItem.title = @"活动";
    huodongVC.tabBarItem.image = [UIImage imageNamed:@"icon_act"];
    huodongVC.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_act_2t"];
    
    WoViewController *woVC = [[WoViewController alloc] init];
    woVC.tabBarItem.title = @"我";
    woVC.tabBarItem.image = [UIImage imageNamed:@"icon_me"];
    woVC.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_me_2t"];
    
    
    UITabBarController * tabBarC = [[UITabBarController alloc] init];
    tabBarC.delegate = self;
    tabBarC.viewControllers = @[shouyeVC,huodongVC,woVC];
    tabBarC.tabBar.tintColor = [UIColor colorWithRed:89/255.0 green:179/255.0 blue:50/255.0 alpha:1];
    
    CGFloat widthM = [UIScreen mainScreen].bounds.size.width;
    CGFloat widthAA = [UIScreen mainScreen].bounds.size.width/tabBarC.viewControllers.count;
    UIView *viewBadge = [[UIView alloc] initWithFrame:CGRectMake(widthM-(widthAA/2-15), 8, 10, 10)];
    viewBadge.backgroundColor = [UIColor redColor];
    viewBadge.layer.cornerRadius = 5;
    viewBadge.layer.masksToBounds = YES;
    viewBadge.tag = 1992;
    viewBadge.hidden = YES;
    [tabBarC.tabBar addSubview:viewBadge];
    
    [self.navigationController pushViewController:tabBarC animated:YES];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    _index = tabBarController.selectedIndex;
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedIndex == 2) {
        NSString *stringPsw = [[NSUserDefaults standardUserDefaults] objectForKey:@"psw"];
        if (!stringPsw) {//没取到密码 请先登录登录
            tabBarController.selectedIndex = _index;
            CompanyViewController *companyVC = [[CompanyViewController alloc] init];
            companyVC.delegate = tabBarController.viewControllers[2];
            companyVC.woVC = tabBarController.viewControllers[2];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:companyVC];
            nav.modalPresentationStyle = 0;
            [self presentViewController:nav animated:YES completion:nil];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

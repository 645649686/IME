//
//  SheZhiViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/10/24.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "SheZhiViewController.h"
#import "VoHeader.h"


#import "SheZheTableViewCell.h"
#import "WebDatailURL.h"

#import "VoHeader.h"

#import "JPUSHService.h"
#import "ShouYeViewController.h"
#import "ZhangHuGuanLiViewController.h"


#import "NSArray+Transition.h"
#import <WebKit/WebKit.h>
#import "IMEProcessPool.h"

typedef NS_ENUM(NSInteger,TableViewTag) {
    TABLEVIEW100 = 100,
    TABLEVIEW101,
    TABLEVIEW102,
};

@interface SheZhiViewController () <UITableViewDelegate,UITableViewDataSource,WKNavigationDelegate> {
    UIActivityIndicatorView *_activityIndicatorView;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (nonatomic,strong) UITableView *tableView100;//个人账号
@property (nonatomic,strong) UITableView *tableView101;//企业管理员
@property (nonatomic,strong) UITableView *tableView102;//企业员工

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation SheZhiViewController

- (UITableView *)tableView100 {
    if (!_tableView100) {
        _tableView100 = [[UITableView alloc] initWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) style:UITableViewStyleGrouped];
        _tableView100.delegate = self;
        _tableView100.dataSource = self;
        [_tableView100 registerNib:[UINib nibWithNibName:@"SheZheTableViewCell" bundle:nil] forCellReuseIdentifier:@"sheZheTableViewCell"];
        _tableView100.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView100.tableFooterView = [UIView new];
        _tableView100.backgroundColor = [UIColor clearColor];
        _tableView100.tag = TABLEVIEW100;
    }
    return _tableView100;
}

- (UITableView *)tableView101 {
    if (!_tableView101) {
        _tableView101 = [[UITableView alloc] initWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) style:UITableViewStyleGrouped];
        _tableView101.delegate = self;
        _tableView101.dataSource = self;
        [_tableView101 registerNib:[UINib nibWithNibName:@"SheZheTableViewCell" bundle:nil] forCellReuseIdentifier:@"sheZheTableViewCell"];
        _tableView101.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView101.tableFooterView = [UIView new];
        _tableView101.backgroundColor = [UIColor clearColor];
        _tableView101.tag = TABLEVIEW101;
    }
    return _tableView101;
}

- (UITableView *)tableView102 {
    if (!_tableView102) {
        _tableView102 = [[UITableView alloc] initWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) style:UITableViewStyleGrouped];
        _tableView102.delegate = self;
        _tableView102.dataSource = self;
        [_tableView102 registerNib:[UINib nibWithNibName:@"SheZheTableViewCell" bundle:nil] forCellReuseIdentifier:@"sheZheTableViewCell"];
        _tableView102.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView102.tableFooterView = [UIView new];
        _tableView102.backgroundColor = [UIColor clearColor];
        _tableView102.tag = TABLEVIEW102;
    }
    return _tableView102;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [self.view addSubview:self.tableView100];
    [self.view addSubview:self.tableView101];
    [self.view addSubview:self.tableView102];
        
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicatorView.frame = CGRectMake(0, 0, kMainW, kMainH);
    _activityIndicatorView.backgroundColor = [UIColor colorWithRed:117/225.0 green:117/225.0 blue:117/225.0 alpha:0.3];
    [self.view addSubview:_activityIndicatorView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView100.hidden = YES;
    self.tableView101.hidden = YES;
    self.tableView102.hidden = YES;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
    for (NSDictionary *dic in array) {
        IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
        if ([loginModel.ucenterId isEqualToString:identityBean.ucenterId]) {
            if ([identityBean.userType isEqualToString:@"NORMAL"]) {
                //个人账号
                self.tableView100.hidden = NO;
                [self.tableView100 reloadData];
                break;
            }
            if ([identityBean.userType isEqualToString:@"ENTERPRISE"] && [identityBean.epAccLevel isEqualToString:@"F"]) {
                //企业管理员
                self.tableView101.hidden = NO;
                [self.tableView101 reloadData];
            }
            if ([identityBean.userType isEqualToString:@"ENTERPRISE"] && [identityBean.epAccLevel isEqualToString:@"C"]) {
                //企业员工
                self.tableView102.hidden = NO;
                [self.tableView102 reloadData];
            }
        }
    }
    
    if (!array) {//解决最开始 加载地区时 登录不上 点击设置界面为空白的情况
        NSLog(@"array 不存在 哈哈哈");
        self.tableView100.hidden = NO;
        [self.tableView100 reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == TABLEVIEW100) {
        if (section == 0) {
            return 1;
        } else if (section == 1) {
            return 2;
        } else if (section == 2) {
            return 2;
        } else {
            return 1;
        }
    }
    if (tableView.tag == TABLEVIEW101) {
        if (section == 0) {
            return 1;
        } else if (section == 1) {
            return 4;
        } else if (section == 2) {
            return 2;
        } else {
            return 1;
        }
    }
    if (tableView.tag == TABLEVIEW102) {
        if (section == 0) {
            return 1;
        } else if (section == 1) {
            return 3;
        } else if (section == 2) {
            return 2;
        } else {
            return 1;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    if (tableView.tag == TABLEVIEW100) {
        SheZheTableViewCell *sheZheTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"sheZheTableViewCell" forIndexPath:indexPath];
        for (UIView *view in sheZheTableViewCell.contentView.subviews) {
            if (view.tag == 10) {
                [view removeFromSuperview];
            }
        }
        sheZheTableViewCell.name.hidden = YES;
        sheZheTableViewCell.imageHeader.hidden = YES;
        sheZheTableViewCell.imageNext.hidden = YES;
        sheZheTableViewCell.viewLineTop.hidden = YES;
        sheZheTableViewCell.viewLineBottomDuan.hidden = YES;
        sheZheTableViewCell.viewLineBottom.hidden = YES;
        
        if (indexPath.section == 0) {
            sheZheTableViewCell.name.hidden = NO;
            sheZheTableViewCell.imageNext.hidden = NO;
            if (indexPath.row == 0) {
                sheZheTableViewCell.imageHeader.hidden = NO;
                sheZheTableViewCell.viewLineTop.hidden = NO;
                sheZheTableViewCell.viewLineBottom.hidden = NO;
                sheZheTableViewCell.name.text = @"帐号管理";
                [sheZheTableViewCell.imageHeader sd_setImageWithURL:[NSURL URLWithString:loginModel.headImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
            }
        }
        if (indexPath.section == 1) {
            sheZheTableViewCell.name.hidden = NO;
            sheZheTableViewCell.imageNext.hidden = NO;
            if (indexPath.row == 0) {
                sheZheTableViewCell.viewLineTop.hidden = NO;
                sheZheTableViewCell.viewLineBottomDuan.hidden = NO;
                sheZheTableViewCell.name.text = @"个人信息";
            }
            if (indexPath.row == 1) {
                sheZheTableViewCell.viewLineBottom.hidden = NO;
                sheZheTableViewCell.name.text = @"交易记录";
            }
        }
        if (indexPath.section == 2) {
            sheZheTableViewCell.name.hidden = NO;
            sheZheTableViewCell.imageNext.hidden = NO;
            if (indexPath.row == 0) {
                sheZheTableViewCell.viewLineTop.hidden = NO;
                sheZheTableViewCell.viewLineBottomDuan.hidden = NO;
                sheZheTableViewCell.name.text = @"账户安全";
            }
            if (indexPath.row == 1) {
                sheZheTableViewCell.viewLineBottom.hidden = NO;
                sheZheTableViewCell.name.text = @"关联账号";
            }
        }
        if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                sheZheTableViewCell.viewLineTop.hidden = NO;
                sheZheTableViewCell.viewLineBottom.hidden = NO;
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainW, 45)];
                label.text = @"账户退出";
                label.textColor = [UIColor blackColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.tag = 10;
                [sheZheTableViewCell.contentView addSubview:label];
            }
        }
        return sheZheTableViewCell;
    } else if (tableView.tag == TABLEVIEW101) {
        SheZheTableViewCell *sheZheTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"sheZheTableViewCell" forIndexPath:indexPath];
        for (UIView *view in sheZheTableViewCell.contentView.subviews) {
            if (view.tag == 10) {
                [view removeFromSuperview];
            }
        }
        sheZheTableViewCell.name.hidden = YES;
        sheZheTableViewCell.imageHeader.hidden = YES;
        sheZheTableViewCell.imageHeader.hidden = YES;
        sheZheTableViewCell.imageNext.hidden = YES;
        sheZheTableViewCell.viewLineTop.hidden = YES;
        sheZheTableViewCell.viewLineBottomDuan.hidden = YES;
        sheZheTableViewCell.viewLineBottom.hidden = YES;
        
        if (indexPath.section == 0) {
            sheZheTableViewCell.name.hidden = NO;
            sheZheTableViewCell.imageNext.hidden = NO;
            if (indexPath.row == 0) {
                sheZheTableViewCell.imageHeader.hidden = NO;
                sheZheTableViewCell.viewLineTop.hidden = NO;
                sheZheTableViewCell.viewLineBottom.hidden = NO;
                sheZheTableViewCell.name.text = @"帐号管理";
                [sheZheTableViewCell.imageHeader sd_setImageWithURL:[NSURL URLWithString:loginModel.headImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
            }
        }
        if (indexPath.section == 1) {
            sheZheTableViewCell.name.hidden = NO;
            sheZheTableViewCell.imageNext.hidden = NO;
            if (indexPath.row == 0) {
                sheZheTableViewCell.viewLineTop.hidden = NO;
                sheZheTableViewCell.viewLineBottomDuan.hidden = NO;
                sheZheTableViewCell.name.text = @"员工管理";
            }
            if (indexPath.row == 1) {
                sheZheTableViewCell.viewLineBottomDuan.hidden = NO;
                sheZheTableViewCell.name.text = @"资金管理";
            }
            if (indexPath.row == 2) {
                sheZheTableViewCell.viewLineBottom.hidden = NO;
                sheZheTableViewCell.name.text = @"收货地址";
            }
            if (indexPath.row == 3) {
                sheZheTableViewCell.viewLineBottomDuan.hidden = NO;
                sheZheTableViewCell.name.text = @"企业信息";
            }
        }
        if (indexPath.section == 2) {
            sheZheTableViewCell.name.hidden = NO;
            sheZheTableViewCell.imageNext.hidden = NO;
            if (indexPath.row == 0) {
                sheZheTableViewCell.viewLineTop.hidden = NO;
                sheZheTableViewCell.viewLineBottomDuan.hidden = NO;
                sheZheTableViewCell.name.text = @"账户安全";
            }
            if (indexPath.row == 1) {
                sheZheTableViewCell.viewLineBottom.hidden = NO;
                sheZheTableViewCell.name.text = @"关联账号";
            }
        }
        if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                sheZheTableViewCell.viewLineTop.hidden = NO;
                sheZheTableViewCell.viewLineBottom.hidden = NO;
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainW, 45)];
                label.text = @"账户退出";
                label.textColor = [UIColor blackColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.tag = 10;
                [sheZheTableViewCell.contentView addSubview:label];
            }
        }
        return sheZheTableViewCell;
    } else {
        SheZheTableViewCell *sheZheTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"sheZheTableViewCell" forIndexPath:indexPath];
        for (UIView *view in sheZheTableViewCell.contentView.subviews) {
            if (view.tag == 10) {
                [view removeFromSuperview];
            }
        }
        sheZheTableViewCell.name.hidden = YES;
        sheZheTableViewCell.imageHeader.hidden = YES;
        sheZheTableViewCell.imageNext.hidden = YES;
        sheZheTableViewCell.viewLineTop.hidden = YES;
        sheZheTableViewCell.viewLineBottomDuan.hidden = YES;
        sheZheTableViewCell.viewLineBottom.hidden = YES;
        
        if (indexPath.section == 0) {
            sheZheTableViewCell.name.hidden = NO;
            sheZheTableViewCell.imageNext.hidden = NO;
            if (indexPath.row == 0) {
                sheZheTableViewCell.imageHeader.hidden = NO;
                sheZheTableViewCell.viewLineTop.hidden = NO;
                sheZheTableViewCell.viewLineBottom.hidden = NO;
                sheZheTableViewCell.name.text = @"帐号管理";
                [sheZheTableViewCell.imageHeader sd_setImageWithURL:[NSURL URLWithString:loginModel.headImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
            }
        }
        if (indexPath.section == 1) {
            sheZheTableViewCell.name.hidden = NO;
            sheZheTableViewCell.imageNext.hidden = NO;
            if (indexPath.row == 0) {
                sheZheTableViewCell.viewLineTop.hidden = NO;
                sheZheTableViewCell.viewLineBottomDuan.hidden = NO;
                sheZheTableViewCell.name.text = @"员工信息";
            }
            if (indexPath.row == 1) {
                sheZheTableViewCell.viewLineBottom.hidden = NO;
                sheZheTableViewCell.name.text = @"资金管理";
            }
            if (indexPath.row == 2) {
                sheZheTableViewCell.viewLineBottomDuan.hidden = NO;
                sheZheTableViewCell.name.text = @"企业信息";
            }
        }
        if (indexPath.section == 2) {
            sheZheTableViewCell.name.hidden = NO;
            sheZheTableViewCell.imageNext.hidden = NO;
            if (indexPath.row == 0) {
                sheZheTableViewCell.viewLineTop.hidden = NO;
                sheZheTableViewCell.viewLineBottomDuan.hidden = NO;
                sheZheTableViewCell.name.text = @"账户安全";
            }
            if (indexPath.row == 1) {
                sheZheTableViewCell.viewLineBottom.hidden = NO;
                sheZheTableViewCell.name.text = @"关联账号";
            }
        }
        if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                sheZheTableViewCell.viewLineTop.hidden = NO;
                sheZheTableViewCell.viewLineBottom.hidden = NO;
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainW, 45)];
                label.text = @"账户退出";
                label.textColor = [UIColor blackColor];
                label.textAlignment = NSTextAlignmentCenter;
                label.tag = 10;
                [sheZheTableViewCell.contentView addSubview:label];
            }
        }
        return sheZheTableViewCell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == TABLEVIEW100) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                ZhangHuGuanLiViewController *zhangHuGuanLiViewController = [[ZhangHuGuanLiViewController alloc] init];
                [self.navigationController pushViewController:zhangHuGuanLiViewController animated:YES];
            }
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                WebDatailURL *webDatailURL = [[WebDatailURL alloc] init];
                webDatailURL.titleTitle = @"个人信息";
                webDatailURL.detailUrl = PostURLSheZhi(@"/ucweb/userInfo/goUserHome.html");
                [self.navigationController pushViewController:webDatailURL animated:YES];
            }
            if (indexPath.row == 1) {
                WebDatailURL *webDatailURL = [[WebDatailURL alloc] init];
                webDatailURL.titleTitle = @"交易记录";
                webDatailURL.detailUrl = PostURLSheZhi(@"/ucweb/trade/getTradeInfo.html");
                [self.navigationController pushViewController:webDatailURL animated:YES];
            }
        }
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                WebDatailURL *webDatailURL = [[WebDatailURL alloc] init];
                webDatailURL.titleTitle = @"账户安全";
                webDatailURL.detailUrl = PostURLSheZhi(@"/ucweb/userSecurity/goUserSecurity.html");
                [self.navigationController pushViewController:webDatailURL animated:YES];
            }
            if (indexPath.row == 1) {
                WebDatailURL *webDatailURL = [[WebDatailURL alloc] init];
                webDatailURL.titleTitle = @"关联账号";
                webDatailURL.detailUrl = PostURLSheZhi(@"/ucweb/userOauth/goUserOauth.html");
                [self.navigationController pushViewController:webDatailURL animated:YES];
            }
        }
        if (indexPath.section == 3) {
            [self backLoginOut];
        }
    }
    
    if (tableView.tag == TABLEVIEW101) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                ZhangHuGuanLiViewController *zhangHuGuanLiViewController = [[ZhangHuGuanLiViewController alloc] init];
                [self.navigationController pushViewController:zhangHuGuanLiViewController animated:YES];
            }
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                WebDatailURL *webDatailURL = [[WebDatailURL alloc] init];
                webDatailURL.titleTitle = @"员工管理";
                webDatailURL.detailUrl = PostURLSheZhi(@"/epweb/childAcc/goChildAcc.html");
                [self.navigationController pushViewController:webDatailURL animated:YES];
            }
            if (indexPath.row == 1) {
                WebDatailURL *webDatailURL = [[WebDatailURL alloc] init];
                webDatailURL.titleTitle = @"资金管理";
                webDatailURL.detailUrl = PostURLSheZhi(@"/epweb/finance/goFinance.html");
                [self.navigationController pushViewController:webDatailURL animated:YES];
            }
            if (indexPath.row == 2) {
                WebDatailURL *webDatailURL = [[WebDatailURL alloc] init];
                webDatailURL.titleTitle = @"收货地址";
                webDatailURL.detailUrl = PostURLSheZhi(@"/epweb/epAdd/epAddDetail.html");
                [self.navigationController pushViewController:webDatailURL animated:YES];
            }
            if (indexPath.row == 3) {
                WebDatailURL *webDatailURL = [[WebDatailURL alloc] init];
                webDatailURL.titleTitle = @"企业信息";
                webDatailURL.detailUrl = PostURLSheZhi(@"/epweb/epInfo/goEpInfo.html");
                [self.navigationController pushViewController:webDatailURL animated:YES];
            }
        }
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                WebDatailURL *webDatailURL = [[WebDatailURL alloc] init];
                webDatailURL.titleTitle = @"账户安全";
                webDatailURL.detailUrl = PostURLSheZhi(@"/epweb/security/goUserSecurity.html");
                [self.navigationController pushViewController:webDatailURL animated:YES];
            }
            if (indexPath.row == 1) {
                WebDatailURL *webDatailURL = [[WebDatailURL alloc] init];
                webDatailURL.titleTitle = @"关联账号";
                webDatailURL.detailUrl = PostURLSheZhi(@"/epweb/oauth/goUserOauth.html");
                [self.navigationController pushViewController:webDatailURL animated:YES];
            }
        }
        if (indexPath.section == 3) {
            [self backLoginOut];
        }
    }
    
    if (tableView.tag == TABLEVIEW102) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                ZhangHuGuanLiViewController *zhangHuGuanLiViewController = [[ZhangHuGuanLiViewController alloc] init];
                [self.navigationController pushViewController:zhangHuGuanLiViewController animated:YES];
            }
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                WebDatailURL *webDatailURL = [[WebDatailURL alloc] init];
                webDatailURL.titleTitle = @"员工信息";
                webDatailURL.detailUrl = PostURLSheZhi(@"/epweb/epInfo/goEpHome.html");
                [self.navigationController pushViewController:webDatailURL animated:YES];
            }
            if (indexPath.row == 1) {
                WebDatailURL *webDatailURL = [[WebDatailURL alloc] init];
                webDatailURL.titleTitle = @"资金管理";
                webDatailURL.detailUrl = PostURLSheZhi(@"/epweb/finance/goFinance.html");
                [self.navigationController pushViewController:webDatailURL animated:YES];
            }
            if (indexPath.row == 2) {
                WebDatailURL *webDatailURL = [[WebDatailURL alloc] init];
                webDatailURL.titleTitle = @"企业信息";
                webDatailURL.detailUrl = PostURLSheZhi(@"/epweb/epInfo/goEpInfo.html");
                [self.navigationController pushViewController:webDatailURL animated:YES];
            }
        }
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                WebDatailURL *webDatailURL = [[WebDatailURL alloc] init];
                webDatailURL.titleTitle = @"账户安全";
                webDatailURL.detailUrl = PostURLSheZhi(@"/epweb/security/goUserSecurity.html");
                [self.navigationController pushViewController:webDatailURL animated:YES];
            }
            if (indexPath.row == 1) {
                WebDatailURL *webDatailURL = [[WebDatailURL alloc] init];
                webDatailURL.titleTitle = @"关联账号";
                webDatailURL.detailUrl = PostURLSheZhi(@"/epweb/oauth/goUserOauth.html");
                [self.navigationController pushViewController:webDatailURL animated:YES];
            }
        }
        if (indexPath.section == 3) {
            [self backLoginOut];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 退出
- (void)backLoginOut {
    
    [_activityIndicatorView startAnimating];
    [HttpMamager postRequestWithURLString:DYZ_user_synlogout parameters:nil success:^(id responseObjectModel) {
        
        LoginModel *obj = responseObjectModel;
        if (obj.resultCode == 0) {
            
            WKWebViewConfiguration *webViewConfiguration = [[WKWebViewConfiguration alloc] init];
            WKUserContentController *contentController = [[WKUserContentController alloc] init];
            webViewConfiguration.userContentController = contentController;
            webViewConfiguration.processPool = [IMEProcessPool shareInstance];
            WKWebView *wkWebView =[[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) configuration:webViewConfiguration];
            wkWebView.navigationDelegate = self;
            [wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[DYZ_user_ssoLogout stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
            [self.view addSubview:wkWebView];
            

            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"psw"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
//            if ([self.delegate respondsToSelector:@selector(loginOutSheZhiViewController)]) {
//                [self.delegate loginOutSheZhiViewController];
//            }
            
            [_activityIndicatorView stopAnimating];
            
//            for (UIViewController *vc in self.navigationController.viewControllers) {
//                if ([vc isMemberOfClass:[UITabBarController class]]) {
//                    UITabBarController *tab = (UITabBarController *)vc;
//                    if ([tab.viewControllers[0] isMemberOfClass:[ShouYeViewController class]]) {
////                        [NSThread sleepForTimeInterval:0.2];
//                        [self.navigationController popToViewController:vc animated:YES];
//                        tab.selectedIndex = 0;
//                        //跳到指定的ViewController tab.selectedIndex = 0 或 tab.selectedViewController = tab.viewControllers[0];
//                        break;
//                    }
//                }
//            }
            
            [JPUSHService setAlias:@"" callbackSelector:nil object:self];
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"退出成功"];
            [DatabaseTool dropLoginModel];
        }
    } fail:^(NSError *error) {
        [_activityIndicatorView stopAnimating];
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"退出失败"];
    } isKindOfModel:NSClassFromString(@"LoginModel")];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [NSThread sleepForTimeInterval:0.2];
    [self clearCookes];
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isMemberOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)vc;
            if ([tab.viewControllers[0] isMemberOfClass:[ShouYeViewController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
                tab.selectedIndex = 0;
                //跳到指定的ViewController tab.selectedIndex = 0 或 tab.selectedViewController = tab.viewControllers[0];
                break;
            }
        }
    }
}

- (void)clearCookes {
    NSSet *websiteDataTypes = [NSSet setWithArray:@[
                                                    WKWebsiteDataTypeDiskCache,
                                                    WKWebsiteDataTypeOfflineWebApplicationCache,
                                                    WKWebsiteDataTypeMemoryCache,
                                                    WKWebsiteDataTypeLocalStorage,
                                                    WKWebsiteDataTypeCookies,
                                                    WKWebsiteDataTypeSessionStorage,
                                                    WKWebsiteDataTypeIndexedDBDatabases,
                                                    WKWebsiteDataTypeWebSQLDatabases
                                                    ]];
    //你可以选择性的删除一些你需要删除的文件 or 也可以直接全部删除所有缓存的type
//    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes
                                               modifiedSince:dateFrom completionHandler:^{
                                                   // code
                                               }];
    
    //    但开发app必须要兼容所有iOS版本，可是iOS8，iOS7没有这种直接的方法，那该怎么办呢？
    //    （iOS7.0只有UIWebView， 而iOS8.0是有WKWebView， 但8.0的WKWebView没有删除缓存方法。）
    //    针对与iOS7.0、iOS8.0、iOS9.0 WebView的缓存，我们找到了一个通吃的办法:
    
    NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]
                            objectForKey:@"CFBundleIdentifier"];
    NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
    NSString *webKitFolderInCaches = [NSString
                                      stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
    NSString *webKitFolderInCachesfs = [NSString
                                        stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
    
    NSError *error;
    /* iOS8.0 WebView Cache的存放路径 */
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
    [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
    
    /* iOS7.0 WebView Cache的存放路径 */
    [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCachesfs error:&error];
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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

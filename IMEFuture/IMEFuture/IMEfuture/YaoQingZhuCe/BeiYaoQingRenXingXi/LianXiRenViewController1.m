//
//  LianXiRenViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/7/24.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "LianXiRenViewController1.h"

#import "Header.h"
#import "MyAlertCenter.h"

#import "XHJAddressBook.h"
#import "PersonModel.h"
#import "PersonCell.h"
#import "BeiYaoQingRenXingXiViewController.h"
#import "LianXiRenSouSuoViewController1.h"


#import "NSString+Utils.h"

#define  mainWidth [UIScreen mainScreen].bounds.size.width
#define  mainHeigth  [UIScreen mainScreen].bounds.size.height

@interface LianXiRenViewController1 () <UITableViewDataSource,UITableViewDelegate> {
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property(nonatomic,strong)NSMutableArray *listContent;
@property (strong, nonatomic) NSMutableArray *sectionTitles;

@property (strong, nonatomic) PersonModel *people;
@property (weak, nonatomic) IBOutlet UITableView *tableShow;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;


@end

@implementation LianXiRenViewController1 {
    XHJAddressBook *_addBook;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    _sectionTitles=[NSMutableArray new];
    
    self.tableShow.delegate=self;
    self.tableShow.dataSource=self;
    self.tableShow.tableFooterView = [UIView new];
    self.tableShow.sectionIndexBackgroundColor=[UIColor clearColor];
    self.tableShow.sectionIndexColor = colorRGB(89, 178, 50);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self initData];
        dispatch_sync(dispatch_get_main_queue(), ^
                      {
                          [self setTitleList];
                          [self.tableShow reloadData];
                      });
    });
    
    
}

- (IBAction)buttonSouSuo:(id)sender {
    LianXiRenSouSuoViewController1 *lianXiRenSouSuoViewController1 = [[LianXiRenSouSuoViewController1 alloc] init];
    [self presentViewController:lianXiRenSouSuoViewController1 animated:YES completion:nil];
}

-(void)setTitleList
{
    UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];
    [self.sectionTitles removeAllObjects];
    [self.sectionTitles addObjectsFromArray:[theCollation sectionTitles]];
    NSMutableArray * existTitles = [NSMutableArray array];
    for(int i=0;i<[_listContent count];i++)//过滤 就取存在的索引条标签
    {
        PersonModel *pm=_listContent[i][0];
        for(int j=0;j<_sectionTitles.count;j++)
        {
            if(pm.sectionNumber==j)
                [existTitles addObject:self.sectionTitles[j]];
        }
    }
    
    [self.sectionTitles removeAllObjects];
    self.sectionTitles =existTitles;
    
}


-(NSMutableArray*)listContent
{
    if(_listContent==nil)
    {
        _listContent=[NSMutableArray new];
    }
    return _listContent;
}
-(void)initData
{
    _addBook=[[XHJAddressBook alloc]init];
    self.listContent=[_addBook getAllPerson];
    if(_listContent==nil)
    {
        NSLog(@"数据为空或通讯录权限拒绝访问，请到系统开启");
        return;
    }
}

//几个  section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_listContent count];
    
}
//对应的section有多少row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[_listContent objectAtIndex:(section)] count];
    
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
//section的高度

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if(self.sectionTitles==nil||self.sectionTitles.count==0)
        return nil;
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"uitableviewbackground"]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = colorRGB(153, 153, 153);
    label.font = [UIFont systemFontOfSize:14];
    NSString *sectionStr=[self.sectionTitles objectAtIndex:(section)];
    [label setText:sectionStr];
    [contentView addSubview:label];
    return contentView;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdenfer=@"addressCell";
    PersonCell *personcell=(PersonCell*)[tableView dequeueReusableCellWithIdentifier:cellIdenfer];
    if(personcell==nil)
    {
        personcell=[[PersonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenfer];
    }
    
    personcell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *sectionArr=[_listContent objectAtIndex:indexPath.section];
    _people = (PersonModel *)[sectionArr objectAtIndex:indexPath.row];
    [personcell setData:_people];
    
    return personcell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *sectionArr=[_listContent objectAtIndex:indexPath.section];
    self.people = (PersonModel *)[sectionArr objectAtIndex:indexPath.row];
    
    if (_people.tel.length == 0) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"当前不支持非空手机号，请见谅"];
        return;
    }
    if (![NSString checkTelNumber:_people.tel]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"当前不支持非手机号"];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(selectLianXiRenWhithStrPhoneNumber:whithStrName:)]) {
        [self.delegate selectLianXiRenWhithStrPhoneNumber:_people.tel whithStrName:_people.phonename];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//开启右侧索引条
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionTitles;
    
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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

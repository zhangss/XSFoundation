//
//  TableHeaderViewController.m
//  XSFoundation
//
//  Created by 张松松 on 15/12/28.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import "TableHeaderViewController.h"
#import "HeaderView.h"
@interface TableHeaderViewController ()
<UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic, assign) CGFloat height;

@end

@implementation TableHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.mainTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, .01f)];
    self.mainTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.mainTableView.showsHorizontalScrollIndicator = NO;
    self.mainTableView.showsVerticalScrollIndicator = NO;
    self.mainTableView.decelerationRate = .01f;
    self.mainTableView.pagingEnabled = YES;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    self.headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250)];
    self.headerView.backgroundColor = [UIColor greenColor];
    self.mainTableView.tableHeaderView = self.headerView;
    [self.view addSubview:self.mainTableView];
    self.height = self.headerView.frame.size.height;
    [self.mainTableView setContentOffset:CGPointMake(0, -150)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Finance_Info_Cell_Identifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(CGPointZero.x, CGPointZero.y, 320, 0)];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGSizeZero.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
//    if (offset.y < 0)
//    {
//        if (offset.y > -60)
//        {
//            [self.mainTableView beginUpdates];
//            CGRect frame = self.headerView.frame;
//            frame.origin.y = - offset.y;
//            frame.size.height = self.height - offset.y;
//            self.headerView.frame = frame;
//            self.mainTableView.tableHeaderView = self.headerView;
//            [self.mainTableView endUpdates];
//        }
//        else
//        {
//            CGRect frame = self.headerView.frame;
//            frame.size.height = self.height + 200;
//            self.headerView.frame = frame;
//        }
//    }
}

@end

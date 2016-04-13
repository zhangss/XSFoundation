//
//  BaseTableViewController.m
//  XSFoundation
//
//  Created by 张松松 on 15/11/13.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import "BaseTableViewController.h"
#import "UIBarButtonItem+NaviItem.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.tableData = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    /**
     *  统一配置
     *  1.背景色
     *  2.LeftBtn
     */
    self.view.backgroundColor = Color_BG;
    if (self.navigationController.childViewControllers.count > 1) {
        [self defaultLeftBackButton];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)defaultLeftBackButton {
    UIImage *backImage = [UIImage imageNamed:@"nav_back_nor.png"];
    UIBarButtonItem *leftBarItem = [UIBarButtonItem itemWidth:60
                                                        image:backImage
                                               imageHighlight:backImage
                                                        title:nil
                                                   titleColor:nil
                                                       target:self
                                                       action:@selector(leftBackButtonClicked)
                                                       offset:CGPointMake(-23, 0)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

- (void)leftBackButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SimpleModel *model = [self.tableData objectAtIndex:indexPath.row];
    BaseViewController *vc = nil;
    NSParameterAssert(model.data);
    NSString *fileName = [model.data stringByAppendingPathExtension:@"nib"]; //不能用xib
    NSString *xibPath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    xibPath = [[NSBundle mainBundle] pathForResource:model.data ofType:@"nib"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:xibPath])
    {
        vc = [[NSClassFromString(model.data) alloc] initWithNibName:model.data bundle:[NSBundle mainBundle]];
    }
    else
    {
        vc = [[NSClassFromString(model.data) alloc] init];
    }
    /**
     *  隐藏Tabbar
     */
    vc.hidesBottomBarWhenPushed = !(self.navigationController.viewControllers.count == 0);
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Normal_Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    SimpleModel *model = [self.tableData objectAtIndex:indexPath.row];
    cell.textLabel.text = model.title;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
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

//
//  TableViewController.m
//  TableViewHeaderViewEnlarge
//
//  Created by 王颜华 on 15/12/6.
//  Copyright © 2015年 EmyWong. All rights reserved.
//

#import "TableViewController.h"
//图片的高度
const CGFloat NYTopViewH = 350;

@interface TableViewController ()
@property (nonatomic, weak) UIImageView *topView;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置内边距(让cell往下移动一段距离)
    self.tableView.contentInset = UIEdgeInsetsMake(NYTopViewH * 0.5, 0, 0, 0);
    
    UIImageView *topView = [[UIImageView alloc] init];
    topView.image = [UIImage imageNamed:@"xiyou.jpg"];
    topView.frame = CGRectMake(0, -NYTopViewH, 320, NYTopViewH);
    
    //设置图片内容模式，让按照原来宽高比缩放
    topView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView insertSubview:topView atIndex:0];
    self.topView = topView;

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
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"测试数据---%ld",(long)indexPath.row];
    
    return cell;

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 向下拽了多少距离
    CGFloat down = -(NYTopViewH * 0.5) - scrollView.contentOffset.y;
    if (down < 0) return;
    
    CGRect frame = self.topView.frame;
    
    // 5决定图片变大的速度,值越大,速度越快
    frame.size.height = NYTopViewH + down * 5;
    self.topView.frame = frame;
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

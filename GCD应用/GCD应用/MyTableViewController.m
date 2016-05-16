//
//  MyTableViewController.m
//  GCD应用
//
//  Created by tarena on 16/5/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyTableViewController.h"
#import "TRDataManager.h"
#import "TableViewCell.h"
#import "Masonry.h"
@interface MyTableViewController ()
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) NSMutableDictionary *imagesData;


@end

@implementation MyTableViewController

-(NSArray *)array{
    if (!_array) {
        _array = [TRDataManager getAlbums];
    }
    return _array;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagesData = [NSMutableDictionary dictionary];
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    self.refreshControl = refresh;
    UIView *view = [[NSBundle mainBundle] loadNibNamed:@"refreshView" owner:nil options:nil].lastObject;
      [refresh addSubview:view];
    
    
    //Masonry约束 左右间距为0
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(10);
    }];
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

    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    TRAlbum *album = self.array[indexPath.row];
    cell.textLabel.text = album.name;
    cell.detailTextLabel.text = album.singer;
    //赋值一个占位图片
    cell.imageView.image = [UIImage imageNamed:@"bg_role2"];
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSData *imageData = [[TRDataManager sharedDataManager] getImagesData:album.poster];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = [UIImage imageWithData:imageData];
        });
    });
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
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

//
//  ViewController.m
//  TestWoo
//
//  Created by 吴远锋 on 2017/5/27.
//  Copyright © 2017年 Wuyuanfeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)NSArray *titleArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    
//    self.navigationItem.backBarButtonItem.title = @"hello"  ;
//    self.navigationController.navigationItem.backBarButtonItem.title= @"hello";
//    self.navigationController.navigationBar.backItem.title = @"hwllo"   ;
//    self.navigationController.navigationBar.backItem.backBarButtonItem.title = @"hwllo";
    
    
//    self.navigationController.navigationBar.barTintColor = [UIColor redColor];


    self.title = @"Test";
    
    
    
    self.edgesForExtendedLayout   = UIRectEdgeNone;
    
    
    [self conFigure];

}


-(NSArray *)titleArray
{
    if (!_titleArray)
    {
        
        _titleArray = [NSArray arrayWithObjects:@"WebviewJavaScript", nil];
        
    }
    
    return _titleArray;
}

-(void)conFigure
{
    self.tableView.frame            = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    self.tableView.tableFooterView = [UIView new];
    
    
    
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"woo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        
        cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[NSClassFromString(@"ImageH5AndObjectC") alloc]init];
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


@end

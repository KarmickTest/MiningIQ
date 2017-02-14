//
//  ProjectofInterestViewController.m
//  mining iQ
//
//  Created by Karmick on 10/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import "ProjectofInterestViewController.h"
#import "ProjectofInterestCell.h"

@interface ProjectofInterestViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    ProjectofInterestCell *cell;
}

@end

@implementation ProjectofInterestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.Project_TableView.delegate=self;
    self.Project_TableView.dataSource=self;
    [self.Project_TableView reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell=[tableView dequeueReusableCellWithIdentifier:@"ProjectofInterestCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
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

- (IBAction)Back_btn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end

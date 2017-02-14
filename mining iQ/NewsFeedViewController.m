//
//  NewsFeedViewController.m
//  mining iQ
//
//  Created by Somnath on 07/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import "NewsFeedViewController.h"

@interface NewsFeedViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation NewsFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Testing git push pull...
}

- (IBAction)backTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = (NewsFeedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"NewsFeedTableViewCell"];
    
    cell.newsImageView.clipsToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.0f;
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

//
//  InformationViewController.m
//  mining iQ
//
//  Created by Somnath on 13/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import "InformationViewController.h"

@interface InformationViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)backTapped:(id)sender {
    
    [[self presentingViewController]dismissViewControllerAnimated:YES completion:NULL];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    if (cell== nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    }
    
    
    cell.textLabel.text = [NSString stringWithFormat:@" Index Path %ld",(long)indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:16];
    cell.textLabel.textColor = [UIColor blackColor];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
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

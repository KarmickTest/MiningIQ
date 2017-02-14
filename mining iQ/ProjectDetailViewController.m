//
//  ProjectDetailViewController.m
//  mining iQ
//
//  Created by Somnath on 10/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import "ProjectDetailViewController.h"

@interface ProjectDetailViewController () <UITableViewDelegate, UITableViewDataSource>
{
    CGSize constraintSize;
    NSMutableArray *contentArr;
}

@end

@implementation ProjectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    contentArr = [[NSMutableArray alloc] initWithObjects:@"COMMENTARY",@"MY REMINDERS", @"MINE OWNERS", @"PROJECT BEGINEERS", @"PROJECT SUPPLIERS", nil];
    
    NSString *str = @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    
    constraintSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width - 40, MAXFLOAT);
    
    CGRect messageRectLeft = [str boundingRectWithSize:constraintSize options:NSStringDrawingUsesFontLeading
                              |NSStringDrawingUsesLineFragmentOrigin|NSLineBreakByWordWrapping|NSLineBreakByCharWrapping attributes:@{NSFontAttributeName:[UIFont fontWithName:@"OpenSans" size:12]} context:nil];
    
    self.headerView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 10 + 35 + 10 + 21 + 10 + messageRectLeft.size.height + 10 + 184 + 10 + 20);
    
    self.projectDescriptionLbl.text = str;
    [self.projectDescriptionLbl sizeToFit];
    
    self.headerSubView.layer.cornerRadius = 4.0;
    self.headerSubView.clipsToBounds = YES;
}

- (IBAction)backTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = (ProjectDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ProjectDetailTableViewCell"];
    
    cell.backView.layer.cornerRadius = 4.0;
    cell.backView.clipsToBounds = YES;
    
    cell.contentLbl.text = [contentArr objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contentArr.count;
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

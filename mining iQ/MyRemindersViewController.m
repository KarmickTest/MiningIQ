//
//  MyRemindersViewController.m
//  mining iQ
//
//  Created by Admin on 08/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import "MyRemindersViewController.h"
#import "MyRemindersCell.h"
#import "NewProjectsViewController.h"



@interface MyRemindersViewController ()

@end

@implementation MyRemindersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)btnOpenMenu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

# pragma mark tableview Delegates and Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 9;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    MyRemindersCell *cell =[tableView dequeueReusableCellWithIdentifier:@"MyRemindersCell"];
//    cell.titleLbl.text = [nameArr objectAtIndex:indexPath.row];
//    cell.imgView.image = [UIImage imageNamed:[imgArr objectAtIndex:indexPath.row]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%ld",(long)indexPath.row);
    
    if(indexPath.row == 1){
        
        NewProjectsViewController *dashBoard=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NewProjectsViewController"];
        [self.navigationController pushViewController:dashBoard animated:YES];
        
    }
    else if (indexPath.row == 4){
        
//        MyRemindersViewController *RemindersView=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MyRemindersViewController"];
//        [self.navigationController pushViewController:RemindersView animated:YES];
        
        
    }
    
    
    
}



@end

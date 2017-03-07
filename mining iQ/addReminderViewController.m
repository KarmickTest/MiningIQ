//
//  addReminderViewController.m
//  mining iQ
//
//  Created by Anirban on 02/03/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import "addReminderViewController.h"
#import "Singelton.h"
#import "DefineHeader.pch"

@interface addReminderViewController ()

@end

@implementation addReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _arr_ProjectDetails=[[NSArray alloc]init];
    
    clear_View=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    clear_View.backgroundColor=[UIColor clearColor];
    clear_View.alpha=0.6f;
    
    [self.view addSubview:clear_View];
    clear_View.hidden=YES;
    
    // =========== Adding spinner ==============
    
    spinnerView = [[UIView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width)/2 - 40, ([UIScreen mainScreen].bounds.size.height)/2 - 40, 80, 80)];
    spinnerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.9];
    spinnerView.layer.cornerRadius = 8.0f;
    spinnerView.clipsToBounds = YES;
    
    /////////// for loader view
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((spinnerView.frame.size.width - 25) / 2), round((spinnerView.frame.size.height - 25) / 2), 25, 25);
    spinner.color = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1];
    [spinner startAnimating];
    
    [spinnerView addSubview:spinner];
    
    [self.view addSubview:spinnerView];
    spinnerView.hidden = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"********");
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self getAllProjects];
}


-(void)getAllProjects
{
     spinnerView.hidden = NO;
    clear_View.hidden=NO;
    NSString *postUrlString=[NSString stringWithFormat:@"limit_start=0&num_records=500"];
    
    NSLog(@"url is : %@",postUrlString);
    
    NSString *strLoginApi=[NSString stringWithFormat:@"%@%@",App_Domain_Url,getallProjects];
    
    [[Singelton getInstance] jsonParseWithPostMethod:^(NSDictionary* testResult){
        
        
        if ([[testResult valueForKey:@"success"] boolValue] == 1)
        {
             spinnerView.hidden = YES;
            clear_View.hidden=YES;
            _arr_ProjectDetails=[testResult valueForKey:@"details"];
        }
        else if ([[testResult valueForKey:@"success"] boolValue] == 0)
        {
            spinnerView.hidden = YES;
            clear_View.hidden=YES;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Something went wrong... please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
        
    } andString:strLoginApi andParam:postUrlString];
}


- (IBAction)backbtnClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btn_Project:(id)sender {
    
    background_View=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    background_View.backgroundColor=[UIColor darkGrayColor];
    background_View.alpha=0.8f;
    
    [self.view addSubview:background_View];
    
    popUp_View=[[UIView alloc]initWithFrame:CGRectMake(35, 65, self.view.frame.size.width-70, self.view.frame.size.height-130)];
    popUp_View.backgroundColor=[UIColor whiteColor];
    popUp_View.alpha=1;
    
    [self.view addSubview:popUp_View];
    
    UILabel *lbl_selectItem=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, popUp_View.frame.size.width/2, 21)];
    
    lbl_selectItem.text=@"Select Item";
    lbl_selectItem.font=[UIFont boldSystemFontOfSize:14];
    
    [popUp_View addSubview:lbl_selectItem];
    
    
    UIButton *popUp_close = [UIButton buttonWithType:UIButtonTypeCustom];
    popUp_close.frame=CGRectMake(popUp_View.frame.size.width-(60+5), 4, 60, 35);
    [popUp_close setTitle:@"CLOSE" forState:UIControlStateNormal];
    [popUp_close setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    popUp_close.titleLabel.font=[UIFont boldSystemFontOfSize:12];
    // popUp_close.backgroundColor=[UIColor redColor];
    [popUp_close addTarget:self action:@selector(PopupClose) forControlEvents:UIControlEventTouchUpInside];
    
    [popUp_View addSubview:popUp_close];

    
    
    
    UITextField *searchField = [[UITextField alloc]initWithFrame:CGRectMake(5, lbl_selectItem.frame.origin.y+lbl_selectItem.frame.size.height+5, popUp_View.frame.size.width-10, 35)];
    searchField.placeholder=@"Search";
    searchField.delegate=self;
    
    [popUp_View addSubview:searchField];
    
    UIView *underline =[[UIView alloc]initWithFrame:CGRectMake(0, searchField.frame.origin.y+searchField.frame.size.height, popUp_View.frame.size.width, 1)];
    underline.backgroundColor=[UIColor grayColor];
    
    [popUp_View addSubview:underline];
    
    
    UITableView *tbl_Project=[[UITableView alloc]initWithFrame:CGRectMake(5, searchField.frame.origin.y+searchField.frame.size.height+10, popUp_View.frame.size.width-10, popUp_View.frame.size.height-(lbl_selectItem.frame.origin.y+lbl_selectItem.frame.size.height+10+40+30))];
    tbl_Project.backgroundColor=[UIColor whiteColor];
    
    tbl_Project.delegate=self;
    tbl_Project.dataSource=self;
    tbl_Project.showsHorizontalScrollIndicator=NO;
    tbl_Project.showsVerticalScrollIndicator=NO;
    
    
    [popUp_View addSubview:tbl_Project];
    
    
    
    
    [tbl_Project reloadData];
}
- (IBAction)btn_Update:(id)sender {
}

-(void)PopupClose{

    [background_View removeFromSuperview];
    [popUp_View removeFromSuperview];


}



#pragma mark Table View Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_arr_ProjectDetails count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = [[_arr_ProjectDetails objectAtIndex:indexPath.row] valueForKey:@"projectname"];
    cell.textLabel.font = [UIFont systemFontOfSize:11];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.ProjectBtn setTitle:[[_arr_ProjectDetails objectAtIndex:indexPath.row] valueForKey:@"projectname"] forState:UIControlStateNormal];
    
    
    NSLog(@"Name: %@",[[_arr_ProjectDetails objectAtIndex:indexPath.row] valueForKey:@"projectname"]);
    NSLog(@"ID: %@",[[_arr_ProjectDetails objectAtIndex:indexPath.row] valueForKey:@"projectid"]);
    
    [background_View removeFromSuperview];
    [popUp_View removeFromSuperview];
}

#pragma mark - TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

@end

//
//  NewsFeedViewController.m
//  mining iQ
//
//  Created by Somnath on 07/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import "NewsFeedViewController.h"
#import "DefineHeader.pch"
#import "Singelton.h"
#import <SafariServices/SafariServices.h>

@interface NewsFeedViewController () <UITableViewDelegate, UITableViewDataSource, SFSafariViewControllerDelegate>
{
    UIView *spinnerView;
    UIActivityIndicatorView *spinner;
    NSMutableArray *newsFeedArr;
}

@end

@implementation NewsFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    /////////// for loader view
    
    spinnerView = [[UIView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width)/2 - 40, ([UIScreen mainScreen].bounds.size.height)/2 - 40, 80, 80)];
    spinnerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.9];
    spinnerView.layer.cornerRadius = 8.0f;
    spinnerView.clipsToBounds = YES;
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((spinnerView.frame.size.width - 25) / 2), round((spinnerView.frame.size.height - 25) / 2), 25, 25);
    spinner.color = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1];
    
    [spinner startAnimating];
    
    [spinnerView addSubview:spinner];
    
    [self.view addSubview:spinnerView];
    spinnerView.hidden = YES;
    
    //////////
    
    [self getttingNewsFeed];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

- (IBAction)backTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getttingNewsFeed
{
    spinnerView.hidden = NO;
    
    NSString *strCategoryApi=[NSString stringWithFormat:@"%@%@",App_Domain_Url,NewsFeed];
    
    newsFeedArr = [[NSMutableArray alloc] init];
    
    [[Singelton getInstance] jsonparse:^(NSDictionary* testResult){
        
        spinnerView.hidden = YES;
        
        if ([[testResult valueForKey:@"success"] boolValue]==1)
        {
            newsFeedArr = [testResult valueForKey:@"details"];
            
            self.newsListTableView.delegate = self;
            self.newsListTableView.dataSource = self;
            [self.newsListTableView reloadData];
            
        }
        else
        {
            
        }
    } andString:strCategoryApi];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = (NewsFeedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"NewsFeedTableViewCell"];
    
    cell.newsTitleLbl.text = [[newsFeedArr objectAtIndex:indexPath.row] valueForKey:@"title"];
    cell.newsDescriptionLbl.text = [[newsFeedArr objectAtIndex:indexPath.row] valueForKey:@"desc"];
    
    cell.newsImageView.clipsToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return newsFeedArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSURL *URL = [NSURL URLWithString:[[newsFeedArr objectAtIndex:indexPath.row] valueForKey:@"link"]];
    
    if (URL) {
        if ([SFSafariViewController class] != nil) {
            SFSafariViewController *sfvc = [[SFSafariViewController alloc] initWithURL:URL];
            sfvc.delegate = self;
            [self presentViewController:sfvc animated:YES completion:nil];
        } else {
            if (![[UIApplication sharedApplication] openURL:URL]) {
                NSLog(@"%@%@",@"Failed to open url:",[URL description]);
            }
        }
    } else {
        // will have a nice alert displaying soon.
    }
}

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    [self dismissViewControllerAnimated:true completion:nil];
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

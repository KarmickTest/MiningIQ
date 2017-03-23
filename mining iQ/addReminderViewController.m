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
#import <CoreData/CoreData.h>


@interface addReminderViewController ()

@end

@implementation addReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _arr_ProjectDetails=[[NSMutableArray alloc]init];
    
    clear_View=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    clear_View.backgroundColor=[UIColor clearColor];
    clear_View.alpha=0.6f;
    
    [self.view addSubview:clear_View];
    clear_View.hidden=YES;
    
    _textView_Description.text = @"Description";
    _textView_Description.textColor=[UIColor lightGrayColor];
    self.str_Project_ID=@"";
    self.str_Date=@"";

    
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
    
    
    
    NSMutableArray* temArray = [[NSMutableArray alloc] init];
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ProjectDetails"];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    temArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    _arr_ProjectDetails = [temArray mutableCopy];

    NSLog(@"*******%lu", (unsigned long)self.arr_ProjectDetails.count);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"********");
}

-(void)viewWillAppear:(BOOL)animated{
    if(_arr_ProjectDetails.count == 0){
    [self getAllProjects];
    }
}


-(void)getAllProjects
{
     spinnerView.hidden = NO;

    clear_View.hidden=NO;
  //  NSString *postUrlString=[NSString stringWithFormat:@"limit_start=0&num_records=500"];

    NSString *postUrlString=[NSString stringWithFormat:@"limit_start=0&num_records=2000"];
    
    NSLog(@"url is : %@",postUrlString);
    
    NSString *strLoginApi=[NSString stringWithFormat:@"%@%@",App_Domain_Url,getallProjects];
    
    [[Singelton getInstance] jsonParseWithPostMethod:^(NSDictionary* testResult){
        
        
        if ([[testResult valueForKey:@"success"] boolValue] == 1)
        {
             spinnerView.hidden = YES;

            clear_View.hidden=YES;
            _arr_ProjectDetails=[testResult valueForKey:@"details"];

          
            if(_arr_ProjectDetails.count == 0){
            
                _arr_ProjectDetails=[[testResult valueForKey:@"details"] mutableCopy];
                [self saveDataInCoreData:_arr_ProjectDetails];
            }
            
            
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
    
    
    background_View=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    background_View.backgroundColor=[UIColor clearColor];
    //background_View.alpha=0.8f;
    
    [self.view addSubview:background_View];
    
    
    
    calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
    self.calendar = calendar;
    calendar.delegate = self;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    self.minimumDate = [self.dateFormatter dateFromString:@"20/09/2012"];
    
    self.disabledDates = @[
                           [self.dateFormatter dateFromString:@"05/01/2013"],
                           [self.dateFormatter dateFromString:@"06/01/2013"],
                           [self.dateFormatter dateFromString:@"07/01/2013"]
                           ];
    
    calendar.onlyShowCurrentMonth = NO;
    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    
    calendar.frame = CGRectMake((self.view.frame.size.width-300)/2, (self.view.frame.size.height-320)/2, 300, 320);
    
   // [self.view addSubview:calendar];
     [background_View addSubview:calendar];
    
//    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(calendar.frame) + 4, self.view.bounds.size.width, 24)];
//    [self.view addSubview:self.dateLabel];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];

    
    
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
    return _arr_ProjectDetails.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSManagedObject *device = [_arr_ProjectDetails objectAtIndex:indexPath.row];
    NSLog(@"...%@",[device valueForKey:@"projectname"]);
    cell.textLabel.text = [device valueForKey:@"projectname"];
    cell.textLabel.font = [UIFont systemFontOfSize:11];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.ProjectBtn setTitle:[[_arr_ProjectDetails objectAtIndex:indexPath.row] valueForKey:@"projectname"] forState:UIControlStateNormal];
    self.str_Project_ID=[[_arr_ProjectDetails objectAtIndex:indexPath.row] valueForKey:@"projectid"];
    
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


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
- (void)saveDataInCoreData:(NSMutableArray *)arrayOfData {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    
    
    NSLog(@"****%lu",(unsigned long)arrayOfData.count);
    
    for(int i=0; i<arrayOfData.count; i++){
        
      NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"ProjectDetails" inManagedObjectContext:context];
    
        [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"area"]) forKey:@"area"];
        [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"projectdeletedornot"]) forKey:@"projectdeletedornot"];
        [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"cap_value"]) forKey:@"cap_value"];
        [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"citiesname"]) forKey:@"citiesname"];
        [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"continentname"]) forKey:@"continentname"];
        [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"countryname"]) forKey:@"countryname"];
        [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"created"]) forKey:@"created"];
        [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"go_live"]) forKey:@"go_live"];
        [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"industiesname"]) forKey:@"industiesname"];
         [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"lastseenthisproject"]) forKey:@"lastseenthisproject"];
         [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"mineralname"]) forKey:@"mineralname"];
        [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"modified"]) forKey:@"modified"];
        [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"plantname"]) forKey:@"plantname"];
        [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"projectdescription"]) forKey:@"projectdescription"];
        [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"projectid"]) forKey:@"projectid"];
        [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"projectname"]) forKey:@"projectname"];
        [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"projectphasename"]) forKey:@"projectphasename"];
        [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"projectypename"]) forKey:@"projectypename"];
        [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"provincename"]) forKey:@"provincename"];
        [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"regionname"]) forKey:@"regionname"];
        [newDevice setValue:NULL_TO_NIL([[arrayOfData objectAtIndex:i] objectForKey:@"statusname"]) forKey:@"statusname"];
    }
    

    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



//  Integrating CK-Calender
// =================================


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)localeDidChange {
    [self.calendar setLocale:[NSLocale currentLocale]];
}

- (BOOL)dateIsDisabled:(NSDate *)date {
    for (NSDate *disabledDate in self.disabledDates) {
        if ([disabledDate isEqualToDate:date]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -
#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {
    // TODO: play with the coloring if we want to...
    if ([self dateIsDisabled:date]) {
        dateItem.backgroundColor = [UIColor redColor];
        dateItem.textColor = [UIColor whiteColor];
    }
}

- (BOOL)calendar:(CKCalendarView *)calendar willSelectDate:(NSDate *)date {
    return ![self dateIsDisabled:date];
}

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    self.dateLabel.text = [self.dateFormatter stringFromDate:date];
    
    [self.Update_Btn setTitle:[self.dateFormatter stringFromDate:date] forState:UIControlStateNormal];
    
    [self.dateFormatter setDateFormat:@"yyyy-mm-dd"];
    self.str_Date=[self.dateFormatter stringFromDate:date];
    
    [background_View removeFromSuperview];
    [calendar removeFromSuperview];
    
    
}

- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date {
    if ([date laterDate:self.minimumDate] == date) {
        self.calendar.backgroundColor = [UIColor blueColor];
        return YES;
    } else {
        self.calendar.backgroundColor = [UIColor redColor];
        return NO;
    }
}

- (void)calendar:(CKCalendarView *)calendar didLayoutInRect:(CGRect)frame {
    NSLog(@"calendar layout: %@", NSStringFromCGRect(frame));
}



// TextView Delegates

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        NSLog(@"Return pressed, do whatever you like here");
         [textView resignFirstResponder];
        return NO; // or true, whetever you's like
    }
    
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textField {
    
    if ([textField.text isEqualToString:@"Description"]) {
        textField.text = @"";
        textField.textColor=[UIColor blackColor];
    }
}


- (void)textViewDidEndEditing:(UITextView *)textField {
    if ([textField.text isEqualToString:@""]) {
        textField.text = @"Description";
        textField.textColor=[UIColor lightGrayColor];
    }
}


- (IBAction)Btn_Submit:(id)sender {
    
    
    if ([self.str_Project_ID isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please select a project." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([self.txtFld_Name.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please give a name." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([self.textView_Description.text isEqualToString:@""] || [self.textView_Description.text isEqualToString:@"Description"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please provide a project description." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([self.str_Date isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please select a date." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        
        spinnerView.hidden = NO;
        
        clear_View.hidden=NO;
        //  NSString *postUrlString=[NSString stringWithFormat:@"limit_start=0&num_records=500"];
        
        NSString *postUrlString=[NSString stringWithFormat:@"userid=222&projectid=%@&name=%@&desc=%@&followupdate=%@",self.str_Project_ID,self.txtFld_Name.text,self.textView_Description.text,self.str_Date,nil];
        
        NSLog(@"url is : %@",postUrlString);
        
        NSString *strLoginApi=[NSString stringWithFormat:@"%@%@",App_Domain_Url,addreminder];
        
        [[Singelton getInstance] jsonParseWithPostMethod:^(NSDictionary* testResult){
            
            
            if ([[testResult valueForKey:@"success"] boolValue] == 1)
            {
                spinnerView.hidden = YES;
                
                clear_View.hidden=YES;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Status" message:[testResult valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
                
                
                _textView_Description.text = @"Description";
                _textView_Description.textColor=[UIColor lightGrayColor];
                
                self.txtFld_Name.text=@"";
                
                [self.ProjectBtn setTitle:@"" forState:UIControlStateNormal];
                self.str_Project_ID=@"";

                [self.Update_Btn setTitle:@"" forState:UIControlStateNormal];
                self.str_Date=@"";
                
                
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
    
    
    
    
    
}
@end

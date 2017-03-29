//
//  DashBoardViewController.m
//  mining iQ
//
//  Created by Anirban on 06/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import "DashBoardViewController.h"
#import "dashBoardCell.h"
#import "NewProjectsViewController.h"
#import "MyRemindersViewController.h"
#import "ProjectSearchViewController.h"
#import "NewsFeedViewController.h"
#import "MenuView.h"
#import "Global_Header.h"
#import "ViewController.h"
#import "ProjectofInterestViewController.h"
#import <CoreData/CoreData.h>
#import "Singelton.h"
#import "DefineHeader.pch"


#define FULLHEIGHT [UIScreen mainScreen].bounds.size.height
#define FULLWIDTH  [UIScreen mainScreen].bounds.size.width
#define MENUHEADERHEIGHT 64.0f
#define ANIMATION_DURATION	0.3f


@interface DashBoardViewController ()<UITableViewDelegate, UITableViewDataSource,MenuViewDelegate>{

    NSMutableArray *nameArr;
    MenuView *objMenuView;
}

@end

@implementation DashBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    self.menu = [[VKSideMenu alloc] initWithSize:220.0f andDirection:VKSideMenuDirectionFromLeft];
//    self.menu.dataSource = self;
//    self.menu.delegate   = self;
//    [self.menu addSwipeGestureRecognition:self.view];
    
    NSMutableDictionary *totalPhases = [[NSMutableDictionary alloc] init];
    [totalPhases setObject:@"Total Phases" forKey:@"headingName"];
    [totalPhases setObject:@"totalPhase" forKey:@"imageName"];
    
    NSMutableDictionary *recentlyUpdated = [[NSMutableDictionary alloc] init];
    [recentlyUpdated setObject:@"Recently Updated" forKey:@"headingName"];
    [recentlyUpdated setObject:@"recentlyUpdate" forKey:@"imageName"];
    
    NSMutableDictionary *newProject = [[NSMutableDictionary alloc] init];
    [newProject setObject:@"New Projects" forKey:@"headingName"];
    [newProject setObject:@"newproject" forKey:@"imageName"];
    
    NSMutableDictionary *myRimdrs = [[NSMutableDictionary alloc] init];
    [myRimdrs setObject:@"My Reminders" forKey:@"headingName"];
    [myRimdrs setObject:@"myRimdrs" forKey:@"imageName"];
    
    NSMutableDictionary *projectsOfInterest = [[NSMutableDictionary alloc] init];
    [projectsOfInterest setObject:@"Projects of Interest" forKey:@"headingName"];
    [projectsOfInterest setObject:@"projectofinterest" forKey:@"imageName"];
    
    NSMutableDictionary *projectSearch = [[NSMutableDictionary alloc] init];
    [projectSearch setObject:@"Project Search" forKey:@"headingName"];
    [projectSearch setObject:@"projectSearch" forKey:@"imageName"];
    
    NSMutableDictionary *newsFeed = [[NSMutableDictionary alloc] init];
    [newsFeed setObject:@"News Feed" forKey:@"headingName"];
    [newsFeed setObject:@"newsfeed" forKey:@"imageName"];
    
//    nameArr = [NSArray arrayWithObjects:@"Total Phases",@"Recently Updated",@"New Projects",@"My Reminders",@"Projects of Interest",@"Project Search",@"News Feed",nil];
//    imgArr = [NSArray arrayWithObjects:@"totalPhase",@"recentlyUpdate",@"newproject",@"myRimdrs",@"myRimdrs",@"projectSearch", @"newsfeed",nil];
    
    nameArr = [[NSMutableArray alloc] initWithObjects:totalPhases,recentlyUpdated,newProject,myRimdrs,projectsOfInterest,projectSearch,newsFeed, nil];
    
    objMenuView = [[MenuView alloc] initWithFrame:CGRectMake(-FULLWIDTH, 0, FULLWIDTH, FULLHEIGHT+MENUHEADERHEIGHT)];
    objMenuView.DelegateMenu = self;
    objMenuView.isMenuopen = FALSE;
    [self.view addSubview:objMenuView];
    objMenuView.menuWidth = FULLWIDTH;
    
    UIPanGestureRecognizer *pangesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [objMenuView setUserInteractionEnabled:YES];
    [objMenuView addGestureRecognizer:pangesture];
    
    
    
    
    spinnerView = [[UIView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width)/2 - 40, ([UIScreen mainScreen].bounds.size.height)/2 - 40, 80, 80)];
    spinnerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.9];
    spinnerView.layer.cornerRadius = 8.0f;
    spinnerView.clipsToBounds = YES;
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((spinnerView.frame.size.width - 25) / 2), round((spinnerView.frame.size.height - 25) / 2), 25, 25);
    spinner.color = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1];
    
    [spinner startAnimating];
    
    [spinnerView addSubview:spinner];
    
    backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.2];
    [backgroundView addSubview:spinnerView];
    
    [self.view addSubview:backgroundView];
    backgroundView.hidden = YES;

    
    //loading all projetlist start
    
    NSMutableArray* temArray = [[NSMutableArray alloc] init];
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ProjectDetails"];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    temArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    _arr_ProjectDetails = [temArray mutableCopy];
    

}


-(void)viewWillAppear:(BOOL)animated
{
    if(_arr_ProjectDetails.count == 0){
        [self getAllProjects];
    }

   
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
//    dispatch_async(queue, ^{
//        // Perform async operation
//        // Call your method/function here
//        // Example:
//        // NSString *result = [anObject calculateSomething];
//        
//        if(_arr_ProjectDetails.count == 0){
//            [self getAllProjects];
//        }
//        
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            // Update UI
//            // Example:
//            // self.myLabel.text = result;
//            
//            
//            //loading all projetlist start
//            NSMutableArray* temArray = [[NSMutableArray alloc] init];
//            NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
//            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ProjectDetails"];
//            [fetchRequest setReturnsObjectsAsFaults:NO];
//            temArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
//            _arr_ProjectDetails = [temArray mutableCopy];
//            
//            
//        });
//    });

    
    
    
}


- (IBAction)openMenu:(id)sender {
    [self drawerMenuOpenClose];
   
}
-(void)TaponcellWithIndex:(NSInteger)Index WithTitle:(NSString *)Title{
    if (Index==0) {
        //[objMenuView removeFromSuperview];
    
    }
    else if (Index==1){
//        [objMenuView removeFromSuperview];
        
        ProjectSearchViewController *RemindersView=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProjectSearchViewController"];
        [self.navigationController pushViewController:RemindersView animated:YES];
       
    }
    else if (Index==2){
//        [objMenuView removeFromSuperview];
          }
    else if (Index==3){
//        [objMenuView removeFromSuperview];
     
    }
    else if (Index==4){
//        [objMenuView removeFromSuperview];
       
        
    }
    else if (Index==5){
//        [objMenuView removeFromSuperview];
     
        
    }
    else if (Index==6){
//        [objMenuView removeFromSuperview];
        
        
    }
    else if (Index==7){
//        [objMenuView removeFromSuperview];
       
    }
    else if (Index==8){
//        [objMenuView removeFromSuperview];
        
    }
    else if (Index==9)
    {
//        [self drawerMenuOpenClose];
        
        CGRect framescreen=objMenuView.frame;
        if (objMenuView.isMenuopen)
        {
            framescreen.origin.x=-(FULLWIDTH);
        }
        else
        {
            framescreen.origin.x=0;
        }
        
        [UIView animateWithDuration:.2f animations:^{
            [objMenuView setFrame:framescreen];
        }
                         completion:^(BOOL finish)
         {
             if (objMenuView.isMenuopen)
             {
                 objMenuView.isMenuopen=FALSE;
             }
             else
             {
                 objMenuView.isMenuopen=TRUE;
             }
             
             ViewController *loginVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
             
             CATransition* transition = [CATransition animation];
             transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
             transition.duration = 0.7f;
             //        transition.subtype =
             transition.type =  kCATransitionFade;
             [self.navigationController.view.layer removeAllAnimations];
             [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
             
             [self.navigationController pushViewController:loginVC animated:NO];
         }];
        
        
    }
    else{
        [self drawerMenuOpenClose];
    }
    
}
- (void)panDetected:(UIPanGestureRecognizer *)panRecognizer
{
    
    
    if (panRecognizer.state == UIGestureRecognizerStateBegan)
    {
        objMenuView.objMenuViewFrame = objMenuView.frame;
        objMenuView.menuWasOpenAtPanBegin = objMenuView.isMenuopen;
        
    }
    CGPoint translation = [panRecognizer translationInView:panRecognizer.view];
    CGRect frame = objMenuView.objMenuViewFrame;
    CGFloat contentViewMinX = [self contentViewMinX];
    if (objMenuView.slideDirection == NVSlideMenuControllerSlideFromRightToLeft21)
    {
        frame.origin.x += translation.x;
        
        if (frame.origin.x < contentViewMinX)
            frame.origin.x = contentViewMinX;
        else if (frame.origin.x > 0)
            frame.origin.x = 0;
    }
    else
    {
        frame.origin.x += translation.x;
        if (frame.origin.x < contentViewMinX)
            frame.origin.x = contentViewMinX;
        else if (frame.origin.x > 0)
            frame.origin.x = 0;
    }
    
    panRecognizer.view.frame = frame;
    
    if (panRecognizer.state == UIGestureRecognizerStateEnded)
    {
        CGPoint velocity = [panRecognizer velocityInView:panRecognizer.view];
        CGFloat distance = 0;
        NSTimeInterval animationDuration = 0;
        
        BOOL close = NO;
        if (objMenuView.slideDirection == NVSlideMenuControllerSlideFromRightToLeft21)
            close = (velocity.x < 0);
        else
            close = (velocity.x > 0);
        
        if (close) // Close
        {
            // Compute animation duration
            
            distance = frame.origin.x;
            animationDuration = fabs(distance / velocity.x);
            if (animationDuration > ANIMATION_DURATION)
                animationDuration = ANIMATION_DURATION;
            
            frame.origin.x = contentViewMinX;
            [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                objMenuView.frame = frame;
            } completion:^(BOOL finished) {
                if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
                    [self setNeedsStatusBarAppearanceUpdate];
                objMenuView.isMenuopen=NO;
                
                
                
            }];
        }
        else // Open
        {
            distance = fabs(contentViewMinX - frame.origin.x);
            animationDuration = fabs(distance / velocity.x);
            if (animationDuration > ANIMATION_DURATION)
                animationDuration = ANIMATION_DURATION;
            
            frame.origin.x = 0;
            
            
            [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                objMenuView.frame = frame;
            } completion:^(BOOL finished)
             {
                 objMenuView.isMenuopen=YES;
             }];
        }
        
        objMenuView.objMenuViewFrame = frame;
    }
    
}


- (CGFloat)contentViewMinX
{
    CGFloat minX = 0;
    
    if ([objMenuView isContentViewHidden])
    {
        if (objMenuView.slideDirection == NVSlideMenuControllerSlideFromRightToLeft21)
            minX = CGRectGetWidth(self.view.bounds);
        else
            minX = -CGRectGetWidth(self.view.bounds);
    }
    else
    {
        if (objMenuView.slideDirection == NVSlideMenuControllerSlideFromRightToLeft21)
            minX = -objMenuView.menuWidth;
        else
            minX = objMenuView.menuWidth;
    }
    
    return minX;
}


- (void)drawerMenuOpenClose{
    CGRect framescreen=objMenuView.frame;
    if (objMenuView.isMenuopen)
    {
        framescreen.origin.x=-(FULLWIDTH);
    }
    else
    {
        framescreen.origin.x=0;
    }
    
    [UIView animateWithDuration:.2f animations:^{
        [objMenuView setFrame:framescreen];
    }
                     completion:^(BOOL finish)
     {
         if (objMenuView.isMenuopen)
         {
             objMenuView.isMenuopen=FALSE;
         }
         else
         {
             objMenuView.isMenuopen=TRUE;
         }
     }];
    
}


# pragma mark tableview Delegates and Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return nameArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    dashBoardCell *cell =[tableView dequeueReusableCellWithIdentifier:@"dashBoardCell"];
    cell.titleLbl.text = [[nameArr objectAtIndex:indexPath.row] valueForKey:@"headingName"];
    cell.imgView.image = [UIImage imageNamed:[[nameArr objectAtIndex:indexPath.row] valueForKey:@"imageName"]];
    
    cell.backView.layer.cornerRadius = 1.0f;
    cell.backView.clipsToBounds = YES;
    cell.backView.backgroundColor = [UIColor colorWithRed:80.0f/255.0f green:80.0f/255.0f blue:80.0f/255.0f alpha:1];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%ld",(long)indexPath.row);
    
    if (indexPath.row == 0){
        
        ProjectPhaseViewController *RemindersView=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProjectPhaseViewController"];
        [self.navigationController pushViewController:RemindersView animated:YES];
        
        
    }
    else if(indexPath.row == 1){
        
        RecentlyUpdatedViewController *RemindersView=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RecentlyUpdatedViewController"];
        [self.navigationController pushViewController:RemindersView animated:YES];
    }
    
    else if (indexPath.row == 2){
        
        NewProjectsViewController *dashBoard=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NewProjectsViewController"];
        [self.navigationController pushViewController:dashBoard animated:YES];
    }

    else if (indexPath.row == 3){
        
        MyRemindersViewController *RemindersView=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MyRemindersViewController"];
        [self.navigationController pushViewController:RemindersView animated:YES];
    }
    else if (indexPath.row == 4){
        
        ProjectofInterestViewController *RemindersView=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProjectofInterestViewController"];
        [self.navigationController pushViewController:RemindersView animated:YES];
        
        
    }
    else if (indexPath.row == 5){
        
        ProjectSearchViewController *RemindersView=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProjectSearchViewController"];
        [self.navigationController pushViewController:RemindersView animated:YES];
    }
    else if (indexPath.row == 6){
        
        NewsFeedViewController *RemindersView=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NewsFeedViewController"];
        [self.navigationController pushViewController:RemindersView animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Add your Colour.
    
    dashBoardCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [self setCellColor:[UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:1] ForCell:cell];
    
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Reset Colour.
    
    dashBoardCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    [self setCellColor:[UIColor colorWithRed:80.0f/255.0f green:80.0f/255.0f blue:80.0f/255.0f alpha:1] ForCell:cell];
}

- (void)setCellColor:(UIColor *)color ForCell:(dashBoardCell *)cellDashboard {
    cellDashboard.backView.backgroundColor = color;
}






//# pragma mark slideMenu Delegates and Datasource
//
//
//
//-(NSInteger)numberOfSectionsInSideMenu:(VKSideMenu *)sideMenu
//{
//    return 1;
//}
//
//-(NSInteger)sideMenu:(VKSideMenu *)sideMenu numberOfRowsInSection:(NSInteger)section
//{
//    return 4;
//}
//
//-(VKSideMenuItem *)sideMenu:(VKSideMenu *)sideMenu itemForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    VKSideMenuItem *item = [VKSideMenuItem new];
//    
//    switch (indexPath.row)
//    {
//        case 0:
//            item.title = @"Profile";
//            item.icon  = [UIImage imageNamed:@"ic_option_1"];
//            break;
//            
//        case 1:
//            item.title = @"Messages";
//            item.icon  = [UIImage imageNamed:@"ic_option_2"];
//            break;
//            
//        case 2:
//            item.title = @"Cart";
//            item.icon  = [UIImage imageNamed:@"ic_option_3"];
//            break;
//            
//        case 3:
//            item.title = @"Settings";
//            item.icon  = [UIImage imageNamed:@"ic_option_4"];
//            break;
//            
//        default:
//            break;
//    }
//    
//    return item;
//}
//-(void)sideMenu:(VKSideMenu *)sideMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"SideMenu didSelectRow: %@", indexPath);
//}
//
//-(void)sideMenuDidShow:(VKSideMenu *)sideMenu
//{
//    NSString *menu = @"";
//    
//    if (sideMenu == self.menu)
//        menu = @"LEFT";
//    else if (sideMenu == self.menu)
//        menu = @"TOP";
//    else if (sideMenu == self.menu)
//        menu = @"RIGHT";
//    else if (sideMenu == self.menu)
//        menu = @"RIGHT";
//    
//    NSLog(@"%@ VKSideMenue did show", menu);
//}
//
//-(void)sideMenuDidHide:(VKSideMenu *)sideMenu
//{
//    NSString *menu = @"";
//    
//    if (sideMenu == self.menu)
//        menu = @"LEFT";
//    else if (sideMenu == self.menu)
//        menu = @"TOP";
//    else if (sideMenu == self.menu)
//        menu = @"RIGHT";
//    else if (sideMenu == self.menu)
//        menu = @"RIGHT";
//    
//    NSLog(@"%@ VKSideMenue did hide", menu);
//}
//
//-(NSString *)sideMenu:(VKSideMenu *)sideMenu titleForHeaderInSection:(NSInteger)section
//{
//    if (sideMenu == self.menu)
//        return nil;
//    
//    switch (section)
//    {
//        case 0:
//            return @"Profile";
//            break;
//            
//        case 1:
//            return @"Actions";
//            break;
//            
//        default:
//            return nil;
//            break;
//    }
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getAllProjects
{
    spinnerView.hidden = NO;
    NSString *postUrlString=[NSString stringWithFormat:@"limit_start=0&num_records=2000"];
    
    NSLog(@"url is : %@",postUrlString);
    
    NSString *strLoginApi=[NSString stringWithFormat:@"%@%@",App_Domain_Url,getallProjects];
    
    [[Singelton getInstance] jsonParseWithPostMethod:^(NSDictionary* testResult){
        
        
        if ([[testResult valueForKey:@"success"] boolValue] == 1)
        {
            spinnerView.hidden = YES;
            
            if(_arr_ProjectDetails.count == 0){
                
                _arr_ProjectDetails=[[testResult valueForKey:@"details"] mutableCopy];
                [self saveDataInCoreData:_arr_ProjectDetails];
            }
            
            
        }
        else if ([[testResult valueForKey:@"success"] boolValue] == 0)
        {
            spinnerView.hidden = YES;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Something went wrong... please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
        
    } andString:strLoginApi andParam:postUrlString];
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



- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
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

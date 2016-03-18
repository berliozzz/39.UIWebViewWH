//
//  MainViewController.m
//  WebViewWH39
//
//  Created by Nikolay Berlioz on 15.03.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "MainViewController.h"
#import "TableData.h"
#import "WebViewController.h"
#import "Item.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *sections;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createItems];
}

#pragma mark - UITableViewDataSource

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self.sections objectAtIndex:section] name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TableData *object = [self.sections objectAtIndex:section];
    
    return [object.contents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    TableData *obj = [self.sections objectAtIndex:indexPath.section];
    
    cell.textLabel.text = [[obj.contents objectAtIndex:indexPath.row] name];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sections count];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WebViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    
    NSURL *url;
    
    if (indexPath.section == 0)
    {
        TableData *object = [self.sections objectAtIndex:indexPath.section];
        Item *item = [object.contents objectAtIndex:indexPath.row];
        
        url = [NSURL fileURLWithPath:item.filePath];
    }
    else
    {
        TableData *object = [self.sections objectAtIndex:indexPath.section];
        Item *item = [object.contents objectAtIndex:indexPath.row];
        
        url = [NSURL URLWithString:item.urlString];
    }
    
    controller.request = [NSURLRequest requestWithURL:url];
    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Private Methods

- (void) createItems
{
    Item *xcoder = [[Item alloc] init];
    Item *prata = [[Item alloc] init];
    Item *yaziki = [[Item alloc] init];
    Item *devCourse = [[Item alloc] init];
    Item *apple = [[Item alloc] init];
    Item *steam = [[Item alloc] init];
    
    xcoder.name = @"BecomeAnXcoder";
    xcoder.filePath = [[NSBundle mainBundle] pathForResource:@"BecomeAnXcoder" ofType:@"pdf"];
    
    prata.name = @"Stiven_Prata_C";
    prata.filePath = [[NSBundle mainBundle] pathForResource:@"Stiven_Prata_C" ofType:@"pdf"];
    
    yaziki.name = @"YazikSi";
    yaziki.filePath = [[NSBundle mainBundle] pathForResource:@"YazikSi" ofType:@"pdf"];
    
    devCourse.name = @"IosDevCourse";
    devCourse.urlString = @"https://vk.com/iosdevcourse";
    
    apple.name = @"Apple";
    apple.urlString = @"https://apple.com";
    
    steam.name = @"Steam";
    steam.urlString = @"http://steamcommunity.com/market/";
    
    
    TableData *pdfContent = [[TableData alloc] init];
    TableData *urlContent = [[TableData alloc] init];
    
    pdfContent.contents = [NSMutableArray arrayWithObjects:xcoder, prata, yaziki, nil];
    pdfContent.name = @"PDF files";
    
    urlContent.contents = [NSMutableArray arrayWithObjects:devCourse, apple, steam, nil];
    urlContent.name = @"URL links";
    
    self.sections = [[NSArray alloc] initWithObjects:pdfContent, urlContent, nil];
}



@end
















//
//  ViewController.m
//  DownloadData1
//
//  Created by tilakkumar gondi on 12/02/15.
//  Copyright (c) 2015 Tilak. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray *arryURLs;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    NSLog(@"%@", self.doc1.titleLabel.text);
    
    self.docListTable.delegate=self;
    self.docListTable.dataSource=self;
    
    //Mutable Array Holding URL Objects of the 
    arryURLs=[NSMutableArray array];
    
    //Adding URLs To The Array.
    [arryURLs addObject:[NSURL URLWithString:@"https://developer.apple.com/library/ios/documentation/DeviceInformation/Reference/iOSDeviceCompatibility/iOSDeviceCompatibility.pdf"]];
    [arryURLs addObject:[NSURL URLWithString:@"https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/URLLoadingSystem/URLLoadingSystem.pdf"]];
    [arryURLs addObject:[NSURL URLWithString:@"https://iseclab.org/papers/egele-ndss11.pdf"]];
    [arryURLs addObject:[NSURL URLWithString:@"https://developer.apple.com/library/prerelease/ios/documentation/Cocoa/Conceptual/URLLoadingSystem/URLLoadingSystem.pdf"]];
    [arryURLs addObject:[NSURL URLWithString:@"https://developer.apple.com/library/ios/documentation/General/Reference/SwiftStandardLibraryReference/SwiftStandardLibraryReference.pdf"]];
    [arryURLs addObject:[NSURL URLWithString:@"https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/ProgrammingWithObjectiveC.pdf"]];
    [arryURLs addObject:[NSURL URLWithString:@"https://developer.apple.com/library/ios/documentation/IDEs/Conceptual/xcode_guide-continuous_integration/Xcode_Continuous_Integration_Guide.pdf"]];
    [arryURLs addObject:[NSURL URLWithString:@"https://developer.apple.com/library/ios/referencelibrary/GettingStarted/RoadMapiOS/RoadMapiOS.pdf"]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark- TableViewDelegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arryURLs.count;
}

#pragma mark- TableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.tag=indexPath.row;
    NSString *fileName = [[arryURLs objectAtIndex:indexPath.row] lastPathComponent];
    
    cell.textLabel.lineBreakMode=NSLineBreakByWordWrapping;
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    cell.textLabel.text=fileName;
    return cell;
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender
{
    NSLog(@"%@",sender);
    if ([segue.identifier isEqualToString:@"doc1"]) {
        MyWebViewController *webVC=segue.destinationViewController;
        
        webVC.urlToLoad=[arryURLs objectAtIndex:sender.tag];
    }
    if ([segue.identifier isEqualToString:@"doc2"]) {
        MyWebViewController *webVC=segue.destinationViewController;
        webVC.urlToLoad=docURL;
    }
}


@end

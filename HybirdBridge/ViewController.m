//
//  ViewController.m
//  HybirdBridge
//
//  Created by wanwu on 2020/7/29.
//  Copyright © 2020 wanwu. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"

@interface ViewController ()
- (IBAction)clickWebViewBtn:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)clickWebViewBtn:(id)sender {
    WebViewController *controller = [[WebViewController alloc] initWithPageUrl:@"user/ExampleApp.html" param:@{}];
    [self.navigationController pushViewController:controller animated:YES];
}
@end

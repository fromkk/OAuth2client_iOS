//
//  HomeViewController.m
//  Oauth2demo
//
//  Created by Kazuya Ueoka on 2015/11/17.
//  Copyright © 2015年 Timers Inc. All rights reserved.
//

#import "HomeViewController.h"
#import "UIAlertController+blocks.h"

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.apiButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.apiButton setTitle:@"API" forState:UIControlStateNormal];
    [self.apiButton addTarget:self action:@selector(apiButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.apiButton];
    
    self.api2Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.api2Button setTitle:@"API2" forState:UIControlStateNormal];
    [self.api2Button addTarget:self action:@selector(api2ButtonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.api2Button];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.apiButton.frame = CGRectMake(10.0f, 100.0f, self.view.frame.size.width - 20.0f, 44.0);
    self.api2Button.frame = CGRectMake(10.0f, CGRectGetMaxY(self.apiButton.frame) + 20.0, self.view.frame.size.width - 20.0, 44.0);
}

#pragma mark - button tapped

- (void)apiButtonDidTapped:(id)sender
{
    NSString *identifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"NXOAuth2AccountIdentifier"];
    NXOAuth2Account *account = nil != identifier ? [[NXOAuth2AccountStore sharedStore] accountWithIdentifier:identifier] : nil;

    [NXOAuth2Request performMethod:@"GET" onResource:[NSURL URLWithString:@"http://localhost:8080/famm/oauth2/api"] usingParameters:nil withAccount:account sendProgressHandler:^(unsigned long long bytesSend, unsigned long long bytesTotal) {
        NSLog(@"%d %d", (int)bytesSend, (int)bytesTotal);
    } responseHandler:^(NSURLResponse *response, NSData *responseData, NSError *error) {
        if (error)
        {
            NSLog(@"error %@", [error localizedDescription]);
            [UIAlertController showAlertWithTitle:nil message:[error localizedDescription] viewController:self];
        } else
        {
            [UIAlertController showAlertWithTitle:nil message:[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] viewController:self];
        }
        
    }];
}

- (void)api2ButtonDidTapped:(id)sender
{
    NSString *identifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"NXOAuth2AccountIdentifier"];
    NXOAuth2Account *account = nil != identifier ? [[NXOAuth2AccountStore sharedStore] accountWithIdentifier:identifier] : nil;
    
    [NXOAuth2Request performMethod:@"GET" onResource:[NSURL URLWithString:@"http://localhost:8080/famm/oauth2/api2"] usingParameters:nil withAccount:account sendProgressHandler:^(unsigned long long bytesSend, unsigned long long bytesTotal) {
        NSLog(@"%d %d", (int)bytesSend, (int)bytesTotal);
    } responseHandler:^(NSURLResponse *response, NSData *responseData, NSError *error) {
        if (error)
        {
            NSLog(@"error %@", [error localizedDescription]);
            [UIAlertController showAlertWithTitle:nil message:[error localizedDescription] viewController:self];
        } else
        {
            [UIAlertController showAlertWithTitle:nil message:[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] viewController:self];
        }
        
    }];
}
@end

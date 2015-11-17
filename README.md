# iOS でOAuthライブラリを利用する方法

今回選定したのは [NXOAuth2Client](https://github.com/nxtbgthng/OAuth2Client)  
※基本的にライブラリのREADME.mdに書いてます

## 初期設定

```objective-c
//AppDelegate.mとかでいいと思う
[[NXOAuth2AccountStore sharedStore] setClientID:@"xXxXxXxXxXxX"
                                             secret:@"xXxXxXxXxXxX"
                                   authorizationURL:[NSURL URLWithString:@"https://...your auth URL..."]
                                           tokenURL:[NSURL URLWithString:@"https://...your token URL..."]
                                        redirectURL:[NSURL URLWithString:@"https://...your redirect URL..."]
                                     forAccountType:@"famm"];
```

## ログイン

```objective-c
[[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType:@"famm"
                                                         username:aUserName
                                                         password:aPassword];
```

## ログイン成功時

`NSNotificationCenter` に `NXOAuth2AccountStoreAccountsDidChangeNotification` のキーで通知を受け取る  
ログインしたアカウントは `NSNotification` から `userInfo` の `NXOAuth2AccountStoreNewAccountUserInfoKey` キーで取得出来る  
※[参考](http://hack.aipo.com/archives/8853/)

## ログイン失敗時

`NSNotificationCenter` に `addObserverForName:NXOAuth2AccountStoreDidFailToRequestAccessNotification` のキーで通知を受け取る

## APIにリクエストする方法

```objective-c
[NXOAuth2Request performMethod:@"GET"
                    onResource:[NSURL URLWithString:@"https://...your service URL..."]
               usingParameters:nil
                   withAccount:loginedAccount
           sendProgressHandler:^(unsigned long long bytesSend, unsigned long long bytesTotal) { // e.g., update a progress indicator }
               responseHandler:^(NSURLResponse *response, NSData *responseData, NSError *error){
                   // Process the response
               }];
```

## 承認済みのURLを取得

```objective-c
NXOAuth2Request *theRequest = [[NXOAuth2Request alloc] initWithResource:[NSURL URLWithString:@"https://...your service URL..."]
                                                                 method:@"GET"
                                                             parameters:nil];
theRequest.account = // ... an loginedAccount

NSURLRequest *sigendRequest = [theRequest signedURLRequest];
```

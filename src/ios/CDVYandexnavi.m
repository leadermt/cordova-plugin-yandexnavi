/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#import "CDVYandexnavi.h"
#import <Cordova/CDV.h>
#import <Foundation/NSURL.h>
#import <Foundation/Foundation.h>

@implementation Yandexnavi

- (void)open: (CDVInvokedUrlCommand*)command {
    NSString *lat_from = [NSString stringWithFormat:@"%@", [command argumentAtIndex:0]];
    NSString *lon_from = [NSString stringWithFormat:@"%@", [command argumentAtIndex:1]];
    NSString *lat_to = [NSString stringWithFormat:@"%@", [command argumentAtIndex:3]];
    NSString *lon_to = [NSString stringWithFormat:@"%@", [command argumentAtIndex:4]];

    NSString *from = @"";
    if([lat_from length] != 0 && [lon_from length] != 0)
		from = [NSString stringWithFormat: @"lat_from=%@&lon_from=%@&", lat_from, lon_from];

    NSString *URL = [NSString stringWithFormat: @"yandexnavi://build_route_on_map?%@lat_to=%@&lon_to=%@", from, lat_to, lon_to];
    NSString* webStringURL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* naviURL = [NSURL URLWithString:webStringURL];

	if ([[UIApplication sharedApplication] canOpenURL:naviURL]) {
	    // Если Навигатор установлен - открываем его
	    [[UIApplication sharedApplication] openURL:naviURL];
	} else {
	    // Если не установлен - открываем страницу в App Store
	    NSURL* appStoreURL = [NSURL URLWithString:@"https://itunes.apple.com/ru/app/yandeks.navigator/id474500851?mt=8"];
	    [[UIApplication sharedApplication] openURL:appStoreURL];
	}
}

@end

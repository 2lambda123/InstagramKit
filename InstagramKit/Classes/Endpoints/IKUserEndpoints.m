//
//    Copyright (c) 2018 Shyam Bhat
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy of
//    this software and associated documentation files (the "Software"), to deal in
//    the Software without restriction, including without limitation the rights to
//    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//    the Software, and to permit persons to whom the Software is furnished to do so,
//    subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "IKUserEndpoints.h"
#import "IKModelsHeader.h"

@implementation IKUserEndpoints


- (void)getUserDetails:(NSString *)userId
           withSuccess:(IKUserBlock)success
               failure:(InstagramFailureBlock)failure
{
    [super getPath:[NSString stringWithFormat:@"users/%@",userId]
    responseModel:[IKUser class]
          success:success
          failure:failure];
}


- (void)updateUserDetails:(IKUser *)user
              withSuccess:(IKUserBlock)success
                  failure:(InstagramFailureBlock)failure
{
    
    [[IKUserEndpoints new] getUserDetails:user.Id
                              withSuccess:^(IKUser * _Nonnull userDetail) {
                                  [user updateDetailsWithUserObject:userDetail];
                                  success(user);
                              } failure:failure];
}

- (void)getMediaForUser:(NSString *)userId
            withSuccess:(IKMediaBlock)success
                failure:(InstagramFailureBlock)failure
{
    [self getMediaForUser:userId
                    count:0
                    maxId:nil
              withSuccess:success
                  failure:failure];
}


- (void)getMediaForUser:(NSString *)userId
                  count:(NSInteger)count
                  maxId:(NSString *)maxId
            withSuccess:(IKMediaBlock)success
                failure:(InstagramFailureBlock)failure
{
    NSDictionary *params = [self parametersFromCount:count
                                               maxId:maxId
                                    andPaginationKey:kPaginationKeyMaxId];
    [super getPaginatedPath:[NSString stringWithFormat:@"users/%@/media/recent",userId]
                parameters:params
             responseModel:[IKMedia class]
                   success:success
                   failure:failure];
}


- (void)searchUsersWithString:(NSString *)name
                  withSuccess:(IKUsersBlock)success
                      failure:(InstagramFailureBlock)failure
{
    [super getPaginatedPath:[NSString stringWithFormat:@"users/search?q=%@",name]
                parameters:nil
             responseModel:[IKUser class]
                   success:success
                   failure:failure];
}


@end
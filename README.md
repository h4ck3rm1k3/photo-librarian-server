photo-librarian-server
======================

A server that graphical photo apps on linux can talk to to post images. replacement for non free web services.


Needs to be run on port 80 to replace facebook, the first target.

Requirements :

For running in apache:
* Plack::Runner


# Facebook implementation

The server when all the facebook requests are directed to it, handles more than just the photo handling, I have added in url handlers for all requests that occured while testing.

The rest api is implemented, but this is deprecated:
http://developers.facebook.com/docs/reference/rest/users.getInfo/
an xml object is expected.

## Facebook communication 
1. get /dialog/oauth
1. users.getLoggedInUser
1. users.getInfo
1. photos.getAlbums
1. photos.createAlbum
1. photos.upload

# Flickr implementation

## Flickr communication
1. get '/services/oauth/request_token'
1. get '/services/oauth/authorize'
1. get '/services/oauth/access_token'
1. get '/services/rest'
1. post '/services/upload'

# picasaweb (broken)
The current stable version uses the deprecated interface

1. user login https://www.google.com/accounts/ClientLogin

   POST /accounts/ClientLogin

The new version uses the oauth2, 

1. get /o/oauth2/auth browse to here and get a token
1. POST /o/oauth2/token enter in app and it posts it here.
1. GET /oauth2/v1/userinfo get the user info
1. GET /data/feed/api/user/default get the albums
1. POST /data/feed/api/user/default post the new album
1. post "/data/feed/api/user/*/albumid/*" upload the data.

        this fails here :https://github.com/h4ck3rm1k3/photo-librarian-server/issues/2
        

See also my blog post on the basic ideas :
http://rdfintrospector2.blogspot.de/2012/09/more-ideas-from-my-kosovo-trip.html


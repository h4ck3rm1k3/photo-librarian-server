photo-librarian-server
======================

A server that graphical photo apps on linux can talk to to post images. replacement for non free web services.


Needs to be run on port 80 to replace facebook, the first target.

Requirements :

For running in apache:
* Plack::Runner


# Facebook implementation

The server when all the facebook requests are directed to it, handles more than just the photo handling, I have added in url handlers for all requests that occured while testing.


See also my blog post on the basic ideas :
http://rdfintrospector2.blogspot.de/2012/09/more-ideas-from-my-kosovo-trip.html
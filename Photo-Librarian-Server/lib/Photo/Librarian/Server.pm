package Photo::Librarian::Server;
use Dancer ':syntax';
use Data::Dumper;

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

# get is called first
get '/restserver.php' => sub {
    #?access_token=
    return "Ok";
};

get '/connect/login_success.html' => sub {
    return "Ok3";
};

#https://www.facebook.com
get '/dialog/oauth' => sub {
    my $redirect_uri= params->{'redirect_uri'};
    warn Dumper(params);
    if ($redirect_uri) {
        warn "going to redirect to :" . $redirect_uri;
        redirect $redirect_uri . "#access_token=this_is_a_faked_access_token2&source=get";
        #?client_id=
        #&redirect_uri=
        #&scope=offline_access,publish_stream,user_photos,user_videos
        #&response_type=token
#    return "Ok2";
    };
};

#/plugins/facepile.php?%20%20%20%20%20%20%20%20%20%20%20%20app_id=49631911630&width=585&size=large&max_rows=1

post '/restserver.php' => sub {
    warn "post handler";

    my %body = params('body');
#    warn Dumper(\%body);
    if ($body{"method"} eq "users.getLoggedInUser") {       
        my $token= params->{'access_token'};    #?access_token=this_is_a_faked_access_token
        warn "got the token $token";
        my $xml= "<root><user><name>somename</name></user></root>";
        #<users_getLoggedInUser_response xmlns="http://api.facebook.com/1.0/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://api.facebook.com/1.0/ http://api.facebook.com/1.0/facebook.xsd">526191113</users_getLoggedInUser_response>
        warn $xml;
        return $xml;
    }
    elsif($body{"method"} eq "users.getInfo") 
    {
        #'method' = 'users.getInfo'
        #'uids' = '526191113'
        #'fields' = 'name'
        my $uids=$body{"uids"};
        return '<?xml version="1.0" encoding="UTF-8"?>
<users_getInfo_response xmlns="http://api.facebook.com/1.0/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://api.facebook.com/1.0/ http://api.facebook.com/1.0/facebook.xsd" list="true">
  <user>
    <uid>' . $uids. ' </uid>
    <name>SOMENAME</name>
  </user>
</users_getInfo_response>
';
        
    }
    elsif($body{"method"} eq "photos.getAlbums")
    {

        return '<?xml version="1.0" encoding="UTF-8"?>
<photos_getAlbums_response xmlns="http://api.facebook.com/1.0/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://api.facebook.com/1.0/ http://api.facebook.com/1.0/facebook.xsd" list="true">
  <album>
    <object_id>428887796113</object_id>
    <aid>2259973621781050653</aid>
    <cover_pid>2259973621791541986</cover_pid>
    <cover_object_id>10151013787456114</cover_object_id>
    <owner>526191113</owner>
    <name>Profile Pictures</name>
    <created>1283522892</created>
    <modified>1347056824</modified>
    <description/>
    <location/>
    <link>http://www.facebook.com/album.php?fbid=428887796113&amp;id=526191113&amp;aid=210205</link>
    <edit_link>http://api.facebook.com/media/set/edit/a.428887796113.210205.526191113/</edit_link>
    <size>49</size>
    <photo_count>49</photo_count>
    <video_count>0</video_count>
    <visible>everyone</visible>
    <type>profile</type>
    <can_upload>0</can_upload>
    <modified_major>1347056822</modified_major>
    <comment_info>
      <can_comment>1</can_comment>
      <comment_count>0</comment_count>
    </comment_info>
    <like_info>
      <can_like>1</can_like>
      <like_count>1</like_count>
      <user_likes>0</user_likes>
    </like_info>
  </album>
</photos_getAlbums_response>
';
    }
    elsif($body{"method"} eq "photos.createAlbum")
    {

        #'name' => 'Shotwell Connect',
        #'method' => '',
        #'privacy' => '{ \\'value\\' : \\'CUSTOM\\', \\'friends\\' : \\'SELF\\' }'

        return '<?xml version="1.0" encoding="UTF-8"?>
<photos_createAlbum_response xmlns="http://api.facebook.com/1.0/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://api.facebook.com/1.0/ http://api.facebook.com/1.0/facebook.xsd">
  <aid>12349973621781263350</aid>
  <cover_pid>0</cover_pid>
  <owner>526191113</owner>
  <name>Shotwell Connect</name>
  <created>1347643108</created>
  <modified>1347643108</modified>
  <description/>
  <location/>
  <link>http://www.facebook.com/album.php?aid=1234902&amp;id=123491113</link>
  <size>0</size>
  <visible>custom</visible>
  <modified_major>1347643108</modified_major>
  <object_id>10151021278231114</object_id>
</photos_createAlbum_response>
';

    }
    elsif($body{"method"} eq "photos.upload")
    {
#           'aid' => '12349973621781263350',
#           '' => 'publishing-0.jpg',
#           'access_token' => 'this_is_a_faked_access_token2',
#           'method' => 'photos.upload',
#           'privacy' => '{ \\'value\\' : \\'CUSTOM\\', \\'friends\\' : \\'SELF\\' }'

        my $filename=$body{""};
        my $all_uploads = request->uploads;

        foreach my $upload (values %{$all_uploads}) {
            warn Dumper($upload);
            $upload->copy_to('/tmp/images/');
        }

#{      'headers' => {
#                       'Content-Type' => 'image/jpeg',
#                        'Content-Disposition' => 'form-data; filename=publishing-4.jpg'
#                   },
#                  'filename' => 'publishing-4.jpg',
#                          'tempname' => '/tmp/Sq8Vg0mR18.jpg',
#                          'size' => '81804'
#                        }, 'Dancer::Request::Upload' )
# }

        return "<ok></ok>";

        
    }
    else 
    {
        warn "error";
        return "ERROR";
    }
    
};


get '/css/error.css' => sub {
    return "";
};

# other facebook api calls

get '/method' => sub {
    return "";
};

get '/dialog/feed' => sub {
    return "";
#https://www.facebook.com/dialog/feed?
#api_key=
#app_id=
#caption=XXXX
#display=popup
#link=XXXX
#locale=en_US
#name=XXXXX
#next=XXXXX
#picture=XXXXXX
#ref=XXXXXX
#sdk=joey

};

get '/connect/xd_arbiter.php' => sub {
    return "";
};

#/plugins/likebox.php?href=http%3A%2F%2Fwww.facebook.com%2Fmixcloud&width=300&height=258&colorscheme=light&show_faces=true&border_color=%23ffffff&stream=false&font=lucida+grande&header=false&appId=261490827272763
get '/plugins/like.php' => sub {
    return "WTF";
};



### Flikr 
# flicker step 1, request token
#http://www.flickr.com/services/oauth/request_token?oauth_nonce=7dc8eb6a0cd7f4ef264c1dad97609e82&oauth_signature_method=HMAC-SHA1&oauth_version=1.0&oauth_callback=oob&oauth_timestamp=1347700042&oauth_consumer_key=60dd96d4a2ad04888b09c9e18d82c26f&oauth_signature=xwoGsfqCirrqRsHdKS2dlG8%2FfIM%3D
get '/services/oauth/request_token' => sub {
    my $redirect_uri= params->{'redirect_uri'};
    my %params=params;

    # 'oauth_signature' => 'irsFmEIINb/bAdQvXEHjiUBCV68=',
    # 'oauth_timestamp' => '1347698428',
    # 'oauth_consumer_key' => '60dd96d4a2ad04888b09c9e18d82c26f',
    # 'oauth_callback' => 'oob',
    # 'oauth_nonce' => 'ba5de4a2344ffb60fe5dfc0ecd37ed31',
    # 'oauth_version' => '1.0',
    # 'oauth_signature_method' => 'HMAC-SHA1'
#    warn Dumper(\%params);
    return "oauth_callback_confirmed=true&oauth_token=1234567890abcdef1-1234567890abcdf1&oauth_token_secret=1234567890abcdef";
};

# now it lauches a browser 
get '/services/oauth/authorize' => sub {
#?oauth_token=1234567890abcdef1-1234567890abcdf1
    return "OK";
};


#now you type the number in and it goes here :
get '/services/oauth/access_token' => sub {
#/services/oauth/access_token?oauth_nonce=841eceb0ae16de8af879f3b7480d4956&oauth_signature_method=HMAC-SHA1&oauth_version=1.0&oauth_callback=oob&oauth_timestamp=1347701942&oauth_consumer_key=60dd96d4a2ad04888b09c9e18d82c26f&oauth_verifier=1234&oauth_token=1234567890abcdef1-1234567890abcdf1&oauth_signature=czqYx1MG%2F%2FeVqoH6Chaz6Vcy%2BeY%3D
    #return "OK";
    return "oauth_token=1234567890abcdef1-1234567890abcdf1&oauth_token_secret=1234567890abcdef&username=whocares";
};

get '/services/rest' => sub {
    my %params = params;
    warn Dumper(\%params);
    return "error" unless $params{"method"};
    if ($params{"method"} eq "flickr.people.getUploadStatus") {       
        return '<?xml version="1.0" encoding="UTF-8"?><rsp stat="ok">
<user id="12037949754@N01" ispro="1">
  <username>Bees</username>
  <bandwidth maxbytes="2147483648" maxkb="2097152" usedbytes="383724" usedkb="374" remainingbytes="2147099924" remainingkb="2096777" />
  <filesize maxbytes="10485760" maxkb="10240" />
  <sets created="27" remaining="lots" />
  <videos uploaded="5" remaining="lots" />
</user>
</rsp>';
      #http://www.flickr.com/services/api/flickr.people.getUploadStatus.htm

    }
    else
    {
        warn "error";
        return "error";
    }
    #method=
#/services/rest?
    #oauth_nonce=67d3411132a3a1fffafa20b700e25df9
    #&oauth_signature_method=HMAC-SHA1
#&oauth_version=1.0
#&oauth_callback=oob
#&oauth_timestamp=1347702192
#&oauth_consumer_key=60dd96d4a2ad04888b09c9e18d82c26f
#&method=flickr.people.getUploadStatus
#&oauth_token=1234567890abcdef1-1234567890abcdf1
#&oauth_signature=CZXynfUxFkwjYG0rDN%2F1hu4OdaU%3D
};


# now manage the upload
post '/services/upload' => sub {
#http://api.flickr.com/services/upload
    my %body = params('body');
    my $filename=$body{""};
    my $all_uploads = request->uploads;    
    foreach my $upload (values %{$all_uploads}) {
        warn Dumper($upload);
        $upload->copy_to('/tmp/images/');
    }
    return "OK";
};

# google search 
#http://www.google.com/search
use WWW::Search::Google;
get '/search' => sub {
    my $q = params->{q};

    return "TODO:$q";
};

true;

package Photo::Librarian::Server;
use Dancer ':syntax';

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

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
    warn "going to redirect to :" . $redirect_uri;
    redirect $redirect_uri . "#access_token=this_is_a_faked_access_token";
    #?client_id=
    #&redirect_uri=
    #&scope=offline_access,publish_stream,user_photos,user_videos
    #&response_type=token
#    return "Ok2";
};

#/plugins/facepile.php?%20%20%20%20%20%20%20%20%20%20%20%20app_id=49631911630&width=585&size=large&max_rows=1

post '/restserver.php' => sub {
    my $token= params->{'access_token'};    #?access_token=this_is_a_faked_access_token
    warn "got the token $token";
    return $token;
};

#/plugins/likebox.php?href=http%3A%2F%2Fwww.facebook.com%2Fmixcloud&width=300&height=258&colorscheme=light&show_faces=true&border_color=%23ffffff&stream=false&font=lucida+grande&header=false&appId=261490827272763
get '/plugins/like.php' => sub {
    return "WTF";
};

get '/css/error.css' => sub {
    return "";
};

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



true;

package Photo::Librarian::Server::Mediawiki;
use Dancer ':syntax';
use Data::Dumper;
our $VERSION = '0.1';
use MediaWiki::API;
use YAML;
use Photo::Librarian::Server;
# handle bot logins t mediawiki
our $lastuser="Mdupont";
get '/w/api.php' => sub {
    my $format= params->{'format'};
    my $action= params->{'action'};
    my $intoken= params->{'intoken'};

    my $ret="BOO";

#/w/api.php?maxlag=5&format=json&action=query&meta=userinfo
    if ($format eq 'json')
    {
        if ($action eq "query")
        {

#    intoken=edit
            if (($intoken ) && ($intoken eq "edit")) {
                $ret= to_json({
                    query => {
                        token =>"yeahright!",
                        pages => {
                            editoken => { 
                                edittoken => "Funky1"
                            }
                        },
                        ,
                    }
                               }
                    );
            } else {
                $ret= to_json(
                    {
                        query => {
                            userinfo => {
                                name => $lastuser,
                                rights => [ "all", "bot"],
                                groups => [ "sysop"]
                            }
                        }
                    }
                    );
            }
        }
        else
        {
            $ret= to_json({});
        }
    }

    warn "Returning $ret";
    return $ret;
};

#0 post login
#1 get the user info 
#GET /w/api.php?maxlag=5&format=json&uiprop=rights%7Cgroups&action=query&meta=userinfo HTTP/1.1"
#2 get a token
# /w/api.php?prop=info&maxlag=5&format=json&titles=TestjzFINxQxn7.jpg&intoken=edit&action=query 


post '/w/api.php' => sub {
    my %body = params('body');
    warn Dumper(\%body);
    my $ret="";
# {
#     'maxlag' => '5',
#     'format' => 'json',
#     'action' => 'login',
#     'lgdomain' => '',
#     'lgpassword' => 'PWD',
#     'lgname' => 'UID'
# };

    my $format= $body{'format'};
    my $action= $body{'action'};
    my $token= $body{'lgtoken'};
    my $username=$body{'lgname'};

    $lastuser=$username;

    if ($format eq 'json')
    {
        if ($action eq 'login')
        {
            if (!$token)
            {
                $ret= to_json(
                    {
                        login => {
                            result => 'NeedToken',
                            token => 'funky2',
                        }
                    }
                    );
            }
            else
            {
                $ret= to_json(
                    {
                        login => {
                            result => 'Success',
                            lgusername => $username,
                        }
                    }
                    );
            }
        }
        elsif ($action eq 'upload')  {
# post the image
        # 'maxlag' => '5',
        # 'format' => 'json',
        # 'comment' => '',
        # 'filename' => 'TestjzFINxQxn7.jpg',
        # 'action' => 'upload',
        # 'file' => 'TestjzFINxQxn7.jpg',
        # 'token' => 'Funky1'

            my $filename=$body{""};
            Photo::Librarian::Server::ProcessUploads (request);
            $ret =to_json(  {} );
        }
        else
        {
            warn "error";
        }
    }
    warn $ret;
    return $ret;
};

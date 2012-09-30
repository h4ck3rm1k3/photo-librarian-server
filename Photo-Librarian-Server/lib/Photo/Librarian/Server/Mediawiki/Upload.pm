package Photo::Librarian::Server::Mediawiki::Upload;
use Photo::Librarian::Server;
use Dancer ':syntax';
use Data::Dumper;
our $VERSION = '0.1';
use MediaWiki::Bot;

get "/images/*.*/upload/commons" => sub {
    my ($filename,$ext)=splat; 
    #warn config->{appdir};
    my $cfile=config->{appdir} . "/commons.yml";
    my $cfg = YAML::LoadFile($cfile);

    my $pfile= $filename . ".". $ext;
    my $file=$Photo::Librarian::Server::datadir . $pfile;
    return "error" if $filename =~ /\//;
    return "error" if $filename =~ /\./;

    my $username = $cfg->{'username'};
    my $password = $cfg->{'password'};
    my $bot = MediaWiki::Bot->new({
        agent   => "Photo::Librarian::Server::MediaWiki::Bot",
        host    => 'commons.wikimedia.org',
        login_data => { username => $username, password => $password },
                                  });
    
    my $status = $bot->upload( {
        title => "Test$pfile",
        file => $file });

    my $html = "<html>";
    $html .= "Test status $status" ;
    $html .= "</html>";
        
    return $html;
};

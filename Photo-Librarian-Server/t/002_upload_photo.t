#
use Test::More tests => 2;
use strict;
use warnings;
use Try::Tiny;
use Photo::Librarian::Server;

my $datadir="/home/mdupont/experiments/photo/";
my ($filename,$ext)=("jzFINxQxn7","jpg");
my $cfile="/home/mdupont/experiments/photo/photo-librarian-server/Photo-Librarian-Server/commons.yml";
my $cfg = YAML::LoadFile($cfile);
my $pfile= $filename . ".". $ext;
my $file=$datadir . $pfile;
my $mw = MediaWiki::API->new();
$mw->{config}->{api_url} = 'http://commons.wikimedia.org/w/api.php';
$mw->login( 
    { 
        lgname => $cfg->{'username'}, 
        lgpassword => $cfg->{'password'} 
    } 
    )
    || die $mw->{error}->{code} . ': ' . $mw->{error}->{details};

# upload a file to MediaWiki

$mw->{config}->{upload_url} = 'http://commons.wikimedia.org/wiki/Special:Upload';

if (1) {
    
    $mw->edit( 
        {
            action => 'upload',
            filename => "TestPhotoLib" . $pfile,
            comment => 'MediaWiki::API Test suite - upload image',
            file => [ $file ],
            ignorewarnings => 1,
            bot => 1
        } 
            );
    
    # $mw->api( {
    # action => 'upload',
    # filename => $pfile,
    # comment => 'a test image',
    # file => [$file],
    #           } );
}
else
{
    open FILE, $file or die $!;
    binmode FILE;
    my ($buffer, $data);
    while ( read(FILE, $buffer, 65536) )  {
        $data .= $buffer;
    }
    close(FILE);
    
    $mw->upload( 
        { 
            title => "TestPhotoLib" . $pfile,
            summary => 'This is test file',
            data => $data 
        } 
        ) || warn $mw->{error}->{code} . ': ' . $mw->{error}->{details};
}

my $html = "<html>";
$html .= "Test";
$html .= "</html>";

warn $html;

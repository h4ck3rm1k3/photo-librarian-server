use strict;
use warnings;
use Test::More 0.88;
use File::Spec;
use YAML;
use MediaWiki::Bot;

my $datadir="/home/mdupont/experiments/photo/";
my ($filename,$ext)=("test","jpg");
my $cfile="/home/mdupont/experiments/photo/photo-librarian-server/Photo-Librarian-Server/commons.yml";
my $cfg = YAML::LoadFile($cfile);
my $pfile= $filename . ".". $ext;
my $file=$datadir . $pfile;
my $username = $cfg->{'username'};
my $password = $cfg->{'password'};

my $bot = MediaWiki::Bot->new({
    agent   => "Photo::Librarian::Server::MediaWiki::Bot",
    host    => 'commons.wikimedia.org',
    login_data => { username => $username, password => $password },
});

my $status = $bot->upload(
    {
        title => "Test$pfile",
        file => $file,
    }
);

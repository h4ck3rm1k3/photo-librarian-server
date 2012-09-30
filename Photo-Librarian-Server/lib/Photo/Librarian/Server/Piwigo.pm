package Photo::Librarian::Server::Piwigo;
use Photo::Librarian::Server;

use Dancer ':syntax';
use Data::Dumper;

our $VERSION = '0.1';

# piwigo support
post '/piwigo/ws.php' => sub {

    my %body = params('body');
    warn Dumper(\%body);
#http://sbfgalleri.web.surftown.se/galleri/tools/ws.htm
#http://sbfgalleri.web.surftown.se/galleri/ws.php
# pwg.caddie.add
# pwg.categories.add
# pwg.categories.delete
# pwg.categories.getAdminList
# pwg.categories.getImages
# pwg.categories.getList
# pwg.categories.move
# pwg.categories.setInfo
# pwg.categories.setRepresentative
# pwg.extensions.checkUpdates
# pwg.extensions.ignoreUpdate
# pwg.extensions.update
# pwg.getInfos
# pwg.getVersion
# pwg.images.add
# pwg.images.addChunk
# pwg.images.addComment
# pwg.images.addFile
# pwg.images.addSimple
# pwg.images.checkFiles
# pwg.images.checkUpload
# pwg.images.delete
# pwg.images.exist
# pwg.images.getInfo
# pwg.images.rate
# pwg.images.resizeThumbnail
# pwg.images.resizeWebsize
# pwg.images.search
# pwg.images.setInfo
# pwg.images.setPrivacyLevel
# pwg.images.setRank
# pwg.plugins.getList
# pwg.plugins.performAction
# pwg.rates.delete
# pwg.session.getStatus
# pwg.session.login
# pwg.session.logout
# pwg.tags.add
# pwg.tags.getAdminList
# pwg.tags.getImages
# pwg.tags.getList
# pwg.themes.performAction
# reflection.getMethodDetails
# reflection.getMethodList
# user_tags.tags.list
# user_tags.tags.update

    if ($body{"method"} eq "pwg.session.login") {       

        # {
        #     'password' => 'fdfs',
        #     'method' => 'pwg.session.login',
        #     'username' => 'fsfsd'
        # };
        cookie pwg_id=>"ldpsl0stv8q0n4uqcl4lp27ng7";

        return "<rsp stat=\"ok\">
            </rsp>";

    }
    #2.0 pwg.session.getStatus
    elsif ($body{"method"} eq "pwg.session.getStatus") {       
        #
        return "<rsp stat=\"ok\">
<username>guest</username>
<status>guest</status>
<theme>SBF_ny</theme>
<language>en_UK</language>
<pwg_token>d8e8a197efb09134c0571b8c71fec4ec</pwg_token>
<charset>utf-8</charset>
<current_datetime>2012-09-17 11:21:00</current_datetime>
</rsp>";

    }
#3
    elsif ($body{"method"} eq "pwg.categories.getList")
    {
        #
        return '<rsp stat="ok">
<categories>
<category id="14" nb_images="668" total_nb_images="668" date_last="2012-01-16 14:10:24" max_date_last="2012-01-16 14:10:24" nb_categories="0" url="http://sbfgalleri.web.surftown.se/galleri/index.php?/category/14-vem_ar_vem">
<name>Vem är vem</name>
<uppercats>14</uppercats>
<global_rank>1</global_rank>
<comment/>
<representative_picture_id>300</representative_picture_id>
<tn_url>
http://sbfgalleri.web.surftown.se/galleri/upload/2012/01/06/thumbnail/TN-20120106131134-67a4301f.jpg
</tn_url>
</category>
</categories>
</rsp>';

    }
    elsif ($body{"method"} eq 'pwg.images.addSimple')
    {      
        warn Dumper(\%body);
#            'level' => '0',
#            'name' => 'cafe, berlin',
#            'method' => 'pwg.images.addSimple',
#            'category' => '14',
#            'tags' => 'test,test2',
        Photo::Librarian::Server::ProcessUploads (request);
        return "<OK></OK>";
    }
    elsif ($body{"method"} eq 'pwg.categories.add')
    {
        my $name = $body{name};
        return '<rsp stat="ok">
<id>1234</id>
</rsp>';

    }
    else
    {
        warn Dumper(\%body);
        return "<ERROR></ERROR>";
    }
    
    
};

# for testing a crash
post '/piwigoccrash/ws.php' => sub {
    return "crash";
};

1;

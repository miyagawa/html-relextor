use strict;
use Test::More tests => 4;

use HTML::RelExtor;

my $html = <<HTML;
<base href="http://barbar.example.com/">
<link href="http://www.example.com/test1" rel="stylesheet" type="text/stylesheet">
<link href="/index.css" rel="stylesheet" type="text/stylesheet" />
HTML
    ;

my $p = HTML::RelExtor->new(base => "http://foobar.example.com/");
$p->xml_mode(1);
$p->parse($html);

my @links = $p->links;

is($links[1]->tag, "link");
is($links[1]->href, "http://barbar.example.com/index.css", $links[1]->href);
is_deeply([$links[1]->rel], [ "stylesheet" ]);
ok($links[1]->has_rel('stylesheet'));


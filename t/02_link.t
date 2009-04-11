use strict;
use Test::More tests => 10;

use HTML::RelExtor;

my $html = <<HTML;
<link href="http://www.example.com/test1" rel="stylesheet" type="text/stylesheet" />
<link href="/index.css" rel="stylesheet" type="text/stylesheet" />
HTML
    ;

my $p = HTML::RelExtor->new(base => "http://foobar.example.com/");
$p->xml_mode(1);
$p->parse($html);

my @links = $p->links;
is(scalar(@links), 2, "2 links with rel");

is($links[0]->tag, "link");
is($links[0]->href, "http://www.example.com/test1");
is_deeply($links[0]->attr, { href => "http://www.example.com/test1",
			     rel => "stylesheet",
			     type => "text/stylesheet" });
is_deeply([$links[0]->rel], [ "stylesheet" ]);
ok($links[0]->has_rel('stylesheet'));

is($links[1]->tag, "link");
is($links[1]->href, "http://foobar.example.com/index.css", $links[1]->href);
is_deeply([$links[1]->rel], [ "stylesheet" ]);
ok($links[1]->has_rel('stylesheet'));


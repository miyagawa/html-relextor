use strict;
use Test::More tests => 13;

use HTML::RelExtor;

my $html = <<HTML;
<a href="http://www.example.com/test1" rel="nofollow">Test1</a>
<a href="http://www.example.com/test2">Test2</a>
<a href="http://www.example.com/test3" rel="nofollow tag">Test3</a>
HTML
    ;

my $p = HTML::RelExtor->new();
$p->parse($html);

my @links = $p->links;
is(scalar(@links), 2, "2 links with rel");

is($links[0]->tag, "a");
is($links[0]->href, "http://www.example.com/test1");
is_deeply($links[0]->attr, { href => "http://www.example.com/test1", rel => "nofollow" });
is_deeply([$links[0]->rel], [ "nofollow" ]);
ok($links[0]->has_rel('nofollow'));
is($links[0]->text, "Test1");

is($links[1]->tag, "a");
is($links[1]->href, "http://www.example.com/test3");
is_deeply([$links[1]->rel], [ "nofollow", "tag" ]);
ok($links[1]->has_rel('nofollow'));
ok($links[1]->has_rel('tag'));
is($links[1]->text, "Test3");

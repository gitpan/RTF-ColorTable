use Test;

BEGIN { plan tests => 9, todo => [ ] }

use strict;
use Carp;

use RTF::ColorTable;
ok(1);

use warnings qw( RTF::ColorTable );
ok(1);

my $colors = RTF::ColorTable->new();
ok(1);

ok(!$colors->count);

my $cBlack = $colors->add_rgb(0,0,0);
ok($colors->count);

ok($colors->is_valid($cBlack));

my $cRed   = $colors->add_rgb(255, 0, 0);
ok($colors->count, 2);

ok($colors->is_valid($cRed));

ok($colors->as_string, '{\colortbl;\red0\green0\blue0;\red255\green0\blue0;}');

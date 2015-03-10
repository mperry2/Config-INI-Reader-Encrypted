#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Config::INI::Reader::Encrypted' ) || print "Bail out!\n";
}

diag( "Testing Config::INI::Reader::Encrypted $Config::INI::Reader::Encrypted::VERSION, Perl $], $^X" );

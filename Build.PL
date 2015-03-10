use 5.006;
use strict;
use warnings FATAL => 'all';
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Config::INI::Reader::Encrypted',
    license             => 'perl',
    dist_author         => q{Matt Perry <matt@mattperry.com>},
    dist_version_from   => 'lib/Config/INI/Reader/Encrypted.pm',
    release_status      => 'stable',
    configure_requires => {
        'Module::Build' => 0,
    },
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        'Carp'            => 0,
        'Crypt::CBC'      => 0,
        'Crypt::Rijndael' => 0,
        'File::Slurp'     => 0,
    },
    add_to_cleanup     => [ 'Config-INI-Reader-Encrypted-*' ],
    create_makefile_pl => 'traditional',
    meta_merge => {
        resources => {
            repository => 'https://github.com/mperry2/Config-INI-Reader-Encrypted'
        }
    },
);

$builder->create_build_script();

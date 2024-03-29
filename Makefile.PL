use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Net::Utils',
    AUTHOR              => q{Michael Kroher <infrared@cpan.org>},
    VERSION_FROM        => 'lib/Net/Utils.pm',
    ABSTRACT_FROM       => 'lib/Net/Utils.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Net-Utils-*' },
);

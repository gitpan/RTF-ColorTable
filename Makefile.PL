use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'RTF::ColorTable',
    'VERSION_FROM'	=> 'ColorTable.pm', # finds $VERSION
    'PREREQ_PM'		=> {
       'warnings::register' => 0,
       'Carp'               => 0,
       'RTF::Group'         => 1.10,
     },
  ($] ge '5.005') ? (
    'AUTHOR'   => 'Robert Rothenberg (rrwo@cpan.org)',
    'ABSTRACT' => 'Generate RTF Color Tables',
  ) : (),
);

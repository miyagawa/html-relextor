use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'      => 'HTML::RelExtor',
    'VERSION_FROM' => 'lib/HTML/RelExtor.pm', # finds $VERSION
    'PREREQ_PM' => {
	Test::More => 0.32,
	HTML::Parser => 3.0,
    },
);

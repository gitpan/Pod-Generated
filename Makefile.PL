use inc::Module::Install;
include 'Module::AutoInstall';

name 'Pod-Generated';
all_from 'lib/Pod/Generated.pm';
perl_version '5.006';

$::IS_MODULE_INSTALL_TEMPLATE = 1;
requires 'Class::ISA';
requires 'Devel::Peek';
requires 'Devel::Symdump';
requires 'Module::Install::Template';
requires 'Text::Conjunct';
requires 'Template';

build_requires 'YAML';
build_requires 'Test::Differences';
build_requires 'Test::More' => '0.70';

use_standard_tests(without => 'pod_coverage');
auto_install;
auto_include;
WriteAll;

use inc::Module::Install;
name 'Pod-Generated';
all_from 'lib/Pod/Generated.pm';
perl_version '5.006';

$::IS_MODULE_INSTALL_TEMPLATE = 1;
requires 'Module::Install::Template';
requires 'Template';

build_requires 'Test::Differences';
build_requires 'Test::More' => '0.70';

install_script glob('bin/*');

use_standard_tests(without => 'pod_coverage');
auto_include;
WriteAll;

use v6.c;
use Test;
use Pod::Load;

diag "Testing strings";
my $string-with-pod = q:to/EOH/;
=begin pod
This ordinary paragraph introduces a code block:
    $this = 1 * code('block');
    $which.is_specified(:by<indenting>);
=end pod
EOH
my $pod = load( $string-with-pod );
ok( $pod, "String load returns something" );
like( $pod.^name, /Pod\:\:/, "That something is a Pod");

diag "Testing files";
for <test.pod6 class.pm6> -> $file {
    my $prefix = $file.IO.e??"./"!!"t/";
    my $file-name = $prefix ~ $file;
    $pod = load( $file-name );
    ok( $pod, "$file-name load returns something" );
    like( $pod.^name, /Pod\:\:/, "That something is a Pod");
    my $io = $file-name.IO;
    $pod = load( $io );
    ok( $pod, "$file load returns something" );
    like( $pod.^name, /Pod\:\:/, "That something is a Pod");
    $pod = load( $io );
    ok( $pod, "$file load returns something and is cached" );

}


done-testing;

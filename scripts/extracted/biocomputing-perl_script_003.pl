use strict;
my $result = system( "ls -l p*" );
print "The result of the system call was as follows:\n$result\n";
$result = 'ls -l p*';
print "The result of the backticks call was as follows:\n$result\n";
$result = qx/ls -l p*/;
print "The result of the qx// call was as follows:\n$result\n";
The invocation of system results in the ls program executing. Any output from
ls is displayed on screen (STDOUT) as normal (as that's what ls does), then, as
ls executed successfully, a value of zero is returned to pinvoke and assigned to
starts with the letter ''p''.
use strict;
use constant URL => "http://pblinux.itcarlow.ie/mersearchmulti.html";
use WWW::Mechanize;
my $browser = WWW::Mechanize->new;
while ( my $seq = <> )
{
chomp( $seq );
print "Now processing: '$seq'.\n";
$browser->get( URL );
$browser->form( 1 );
$browser->field( "shortsequence", $seq );
$browser->submit;
if ( $browser->success )
{
my $content = $browser->content;
while ( $content =~
m[<tr align="CENTER" /><td>(\w+?)</td><td>yes</td>]g )
{
print "\tAccession code: $1 matched '$seq'.\n";
}
}
else
{
print "Something went wrong: HTTP status code: ",
$browser->status, "\n";
}
}
Let's go through the automatch program in detail. After the standard first
line and the switching on of strictness, a constant called URL is defined. This
constant value is a web address, specifying the mersearchmulti.html web page
on the pblinux.itcarlow.ie web server2. The WWW::Mechanize module is
then used.
A scalar value called $browser is assigned a value as a result of calling the
new subroutine associated with the WWW::Mechanize module. In programming
terms, this creates a WWW::Mechanize object and assigns it to $browser. Do not
web page is installed.

Web Automation
statement creates a WWW::Mechanize thingy and assigns it to $browser:
my $browser = WWW::Mechanize->new;
A while loop reads one line at a time from STDIN and assigns it to the $seq
scalar. Within the loop body, the value within $seq is chomped, and a message is
displayed on screen to provide some feedback to the user. The $browser object
is used in the next four statements:
$browser->get( URL );
$browser->form( 1 );
$browser->field( "shortsequence", $seq );
$browser->submit;
in the form of subroutines that can be invoked against the object. The get
subroutine (which is part of the WWW::Mechanize module) takes a web address
and retrieves the web page returned from the web server. The web page returned
is associated with the $browser object, which highlights another nice thing about
objects: they can have data associated with them.
Technical Commentary:
Objects are useful, and clever programmers use them to
the scope of this book to cover the object-creating techniques available to Perl
programmers. However, it is not necessary to know how to create objects in order
to be able to exploit and use them, as witnessed by the automatch program.
With the returned web page contained in the $browser object, the form sub-
routine selects the first form contained within the returned web page. Unlike
almost everything else in Perl, the form subroutine starts counting from one,
not zero. It is possible to have more than one form on a HTML page, but the
mersearchmulti.html web page has only one, so automatch selects it. The
field subroutine provides a mechanism to set a specific field on the form to
a value. The invocation within automatch sets the value of the shortsequence
textarea to the value contained within the $seq scalar. With this done, the submit
subroutine clicks the forms main button, which is the Try it! button from the
mersearchmulti.html web page.
At this point, the automatch program sends a request to the web server.
This results in the CGI on the web server executing, using the $seq value as a
parameter. The CGI executes and produces the results page. This is then returned
to the automatch program and is assigned, by the WWW::Mechanize module, to
the $browser object. An if statement checks to see if the request was successful
by calling the success subroutine associated with the $browser object. If it is
not, a message is displayed on STDOUT. Note that the message contains a status
code from the $browser object:
use strict;
use CGI qw/:standard/;
print header;
open EMBLENTRY, "embl.data.out"
or die "No data-file: have you executed prepare_embl?\n";

Web Technologies
my $sequence = <EMBLENTRY>;
close EMBLENTRY;
print start_html( "The results of your search are in!" );
print "Length of sequence is: <b>", length $sequence,
"</b> characters.<p>";
print h3( "Here is the result of your search:" );
my $to_check = param( "shortsequence" );
$to_check = lc $to_check;
if ( $sequence =~ /$to_check/ )
{
print "Found.
The EMBL data extract contains: <b>$to_check</b>.";
}
else
{
print "Sorry.
No match found for: <b>$to_check</b>.";
}
print p, hr,p;
print "Press <b>Back</b> on your browser to try another search.";
print end_html;
The match emblCGI program is very similar to the match embl program, except
for all the extra HTML-specific program code. Rather than produce straight text, a
HTML web page is produced instead. Note the use of the h3 subroutine (from CGI)
that adds a level three HTML header to the web page. The p and hr subroutines
(also from CGI) insert a paragraph break and horizontal rule, respectively. The
critical line of code is this one:
my $to_check = param( "shortsequence" );
which uses the CGI-supplied param subroutine to assign the web browser-
supplied value associated with shortsequence to the $to check scalar. But
just what is shortsequence and when is its value set?
The shortsequence parameter is set within a web page, specifically within
a web page that contains a form. It is a HTML named parameter. Here's a
HTML page called mersearch.html that associates shortsequence with a HTML
textarea component within a form:
<HTML>
<HEAD>
<TITLE>Search the Sequence for a Match</TITLE>
</HEAD>
<BODY>
#!/usr/bin/perl
use strict;
use warnings;
use CGI qw/:standard/;
my $time = localtime;
print
header,
start_html('Double stranded RNA can regulate genes'),
h2('Double stranded RNA can regulate genes'),
start_form,
p,
"A recent article in <b>Nature</b> describes the important
discovery of <i>RNA interference</i>, the action of snippets
of double-stranded RNA in suppressing gene expression.",
p,
"The discovery has provided a powerful new tool in investigating
gene function, and has raised many questions about the
nature of gene regulation in a wide variety of organisms.",
p,
"This page was created $time.",
p,
end_form;
into the program's namespace by the directive use CGI qw/:standard/;.
paragraph of text. Finally, the function end_form closes the HTML document.
program cgiex1.cgi:
<html>
<head>
<title>Double stranded RNA can regulate genes</title>
</head>
<body>
<h2>Double stranded RNA can regulate genes</h2>
<p>A recent article in <b>Nature</b> describes the important
discovery of <i>RNA interference</i>, the action of snippets
of double-stranded RNA in suppressing gene expression.

</p>
<p>
The discovery has provided a powerful new tool in investigating
gene function, and has raised many questions about the
nature of gene regulation in a wide variety of organisms.
</p>
<p>
This page was created Tue Apr 15 09:42:49 2003.
</p>
</body>
</html>
didn't use CGI.pm but simply output the HTML code. However, as you write more complicated
test a CGI web program?
First, check the basic syntax by running:
perl -c cgiex1.cgi
and, hopefully, getting the message:
cgiex1.cgi syntax OK
and so forth, as I'll demonstrate in a moment.
Copy your CGI program cgiex1.cgi into your CGI directory (on my system, it's
executable by typing:
chmod 755 /var/www/cgi-bin/cgiex1.cgi
Let's try the program out. Start up a web browser and type in the URL 
It worked! But what would you do if it doesn't? Even though you check the syntax, the

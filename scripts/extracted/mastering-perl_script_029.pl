use CGI;
You then use the CGI.pm methods so that your Perl program outputs the code for the web
web browser as a URL. The web browser sends the request to the web server, which
displayed as a web page (or image, sound, or whatever).
dynamic, I'll add a little code that includes the time of day:
#!/usr/bin/perl
use strict;
use warnings;
my $time = localtime;
print "Content-type: text/html\n\n";
print <<EndOfHTML;
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
This page was created $time.
</p>
</body>
</html>
EndOfHTML
"Content-type: text/html\n\n"; before printing the HTML code as the body of the
response. Notice the two \n's in that header line; these print a blank line between the header
and the body of the response, as described earlier in this chapter.
Also, notice a new last paragraph that reports the time.
server. Because of the multiplicity of web servers and operating systems, it is not possible for
me to be comprehensive on this point. On my Linux system, using the Apache web server, I
/var/www/cgi-bin, and then typed:
chmod 755 /var/www/cgi-bin/cgiex1
machine, the details are a little different; consult the documentation for your web server to
see how to install a CGI script in the appropriate place.
Once I've installed the script, I simply entered the following URL into my web browser. Notice
computer on which I'm using the web browser.
http://localhost/cgi-bin/cgiex1
my web browser (see Figure 7-2).

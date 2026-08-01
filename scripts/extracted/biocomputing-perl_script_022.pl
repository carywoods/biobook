use strict;
use CGI qw( :standard );
print start_html( 'What Date and Time Is It?' ),
"The current date/time is: ", scalar localtime,
end_html;
which, when executed, produces the following HTML:
<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html
PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US" xml:lang="en-US">
<head><title>What Date and Time Is It?</title></head>
<body>The current date/time is: Mon Aug 25 23:21:55 2003</body></html>
And there it is, surrounded by the <BODY> and </BODY> tags, the date and time
when the page was created. Execute the program sometime later, and the date
and time change (as expected):
<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html
PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US" xml:lang="en-US">
<head><title>What Date and Time Is It?</title></head>
<body>The current date/time is: Tue Aug 26 08:04:23 2003</body></html>
This web page, if served up by a web server, changes with each serving, as it is
dynamic.
Note the use of the ''T'' command-line option at the start of whattimeisit.
on the behaviour of the program. Enabling these checks is particularly important
when it comes to server-side programs. Be advised that although the program is
from a user of a web browser on the WWW, the user may or may not be a trusted
source: it could literally be anybody.
If a server-side program does something that could potentially be exploited
when taint mode is enabled. Here's a really important maxim.
Maxim 15.3 Always enable ''taint mode'' for server-side programs.

Web Technologies
15.3
Preparing Apache for Perl
Arranging for a web server to serve up any web page, whether static or dynamic,
involves configuring the server to display the static web page or execute the
server-side program as a result of a request from a web browser. Before doing
As with MySQL earlier in this book, the Linux chkconfig command is used to
add the Apache web server program and get it ready:
chkconfig
--add
httpd
chkconfig
httpd
on
On Linux systems, httpd is the name commonly given to the web-serving pro-
gram.
The Apache web server is by far the most widespread web-server imple-
mentation, and its configuration details are maintained within a disk-file called
httpd.conf. It is important to check (and possibly adjust) some of the set-
tings in this disk-file. This can be accomplished only by the superuser (root on
Linux). After becoming the superuser (or logging in as root), find the httpd.conf
disk-file using the locate utility:
locate
httpd.conf
On Paul's computer (running RedHat Linux), the above locate command pro-
duces the following output:
/etc/httpd/conf/httpd.conf
/usr/share/apacheconf/httpd.conf.xsl
2 of the httpd.conf disk-file, adjust the server administrator's e-mail address
to something other than the default, which may look something like this:
ServerAdmin root@localhost
Whenever a problem occurs with a request on the web server, the web browser
is told about the problem and given an e-mail address to which to send a
''complaint message'' (when appropriate). The e-mail address to use is set by the
ServerAdmin directive.
Later in the httpd.conf disk-file, the DocumentRoot directive indicates the
default directory location for static web pages:
DocumentRoot "/var/www/html"
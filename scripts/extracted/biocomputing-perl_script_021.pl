use strict;
use CGI qw( :standard );
print start_html( 'A Simple HTML Page' ),
"This is as simple a web page as there is.",
end_html;
Among other things, the CGI module is designed to make the production of
HTML pages as convenient as possible. Written by Lincoln D. Stein, this module
is, more than likely, the most-used module of all of those that come with Perl
(after strict, that is). In fact, CGI can claim to account for Perl's huge popularity
as a server-side programming technology on the WWW.
Technical Commentary:
An interesting aside regarding the CGI module relates
tools. Dr Stein is as well regarded for his contributions to the Perl programming
community as he is for his contributions to, and observations of, the field of
Bioinformatics. Among other things, Dr Stein has worked extensively on the AceDB
database.
The produce simpleCGI program uses the CGI module, importing a set of
subroutines by specifying the :standard tag. Some of these subroutines are
used within the program's sole print statement:
print start_html( 'A Simple HTML Page' ),
"This is as simple a web page as there is.",
end_html;
The print statement contains invocation of two CGI subroutines, start html
and end html. When invoked, the start html subroutine produces the tags
that appear at the start of a web page. Any string supplied as a parameter to
start html is used as the web page's title. The above invocation produces the
following HTML:
<html><head><title>A Simple HTML Page</title></head><body>

Web Technologies
The end html subroutine produces the following HTML, representing the tags
that conclude a web page:
</body></html>
As the invocations of both of these subroutines occur as part of a print
statement, they are displayed on STDOUT, together with the one-line message
(which is the actual content). When executed, the produce simpleCGI program
generates the following HTML3:
<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html
PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US" xml:lang="en-US">
<head><title>A Simple HTML Page</title>
</head><body>This is as simple a web page as there is.</body></html>
The web page displays in any browser regardless. What these extra tags do is
tell the web browser exactly which version of HTML the web page conforms to.
The CGI module includes these tags for web browsers that can interpret the
information, allowing the browser to optimise its behaviour to the version of
HTML identified. Other web browsers simply ignore them.
The static creation of WWW content
The simple.html web page, as well as being simple, is also static. If the web
page is put on a web server, and served up to a web browser, it always appears
web page with a program unless there is some other special requirement.
Maxim 15.2 Create static web pages either manually or visually.
The dynamic creation of WWW content
web page. An example of a dynamic web page is one that includes the current
date and time. It is not possible to create a web page either manually or visu-
ally that includes dynamic content, and this is where server-side programming
technologies come into their own. Here's a program, called whattimeisit, that
creates a HTML page that includes the current date and time:
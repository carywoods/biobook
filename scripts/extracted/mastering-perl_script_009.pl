#!/usr/bin/perl
# webrebase1 - a web interface to the Rebase modules
# To install in web, make a directory to hold your Perl modules in web space
use lib "/var/www/html/re";
use Restrictionmap;
use Rebase;
use SeqFileIO;
use CGI qw/:standard/;
use strict;
use warnings;
   print header,
   start_html('Restriction Maps on the Web'),
   h1('<font color=orange>Restriction Maps on the Web</font>'),
   hr,
   start_multipart_form,
   '<font color=blue>',
   h3("1) Restriction enzyme(s)?  "),
   textfield('enzyme'), p,
   h3("2) Sequence filename (fasta or raw format):  "),
   filefield(-name=>'fileseq',
       -default=>'starting value',
       -size=>50,
       -maxlength=>200,
   ), p,
   strong(em("or")),
   h3("Type sequence:  "),
   textarea(
       -name=>'typedseq',
       -rows=>10,
       -columns=>60,
       -maxlength=>1000,

   ), p,
   h3("3) Make restriction map:"),
   submit, p,
   '</font>',
   hr,
   end_form;
if (param(  )) {
   my $sequence = '';
   # must have exactly one of the two sequence input methods specified
   if(param('typedseq') and param('fileseq')) {
       print "<font color=red>You have given a file AND typed in sequence:
do only one!</font>", hr;
              exit;
   }elsif(not param('typedseq') and not param('fileseq')) {
       print "<font color=red>You must give a sequence file OR type in
sequence!</
font>", hr;
       exit;
   }elsif(param('typedseq')) {
       $sequence = param('typedseq');
   }elsif(param('fileseq')) {
       my $fh = upload('fileseq');
       while (<$fh>) {
           /^\s*>/ and next; # handles fasta file headers
           $sequence .= $_;
       }
   }
   # strip out non-sequence characters
   $sequence =~ s/\s//g;
   $sequence = uc $sequence;
   my $rebase = Rebase->new(
       #omit "bionetfile" attribute to avoid recalculating the DBM file
       dbmfile => 'BIONET',
       mode => '0444',
   );
   my $restrict = Restrictionmap->new(
       enzyme => param('enzyme'),
       rebase => $rebase,
       sequence => $sequence,
       graphictype => 'text',
   );
  
   print "Your requested enzyme(s): ",em(param('enzyme')),p,
   "<code><pre>\n";
   (my $paramenzyme = param('enzyme')) =~ s/,/ /g;
   foreach my $enzyme (split(" ", $paramenzyme)) {
       print "Locations for $enzyme: ",
       join(' ', $restrict->get_enzyme_map($enzyme)), "\n";
   }
   print "\n\n\n";
   print $restrict->get_graphic,
   "</pre></code>\n",
   hr;
}

print end_html;
chapter, such as cgiex1.cgi. However, because this program depends on several modules,
from your own directories. Also, if you try out a change that doesn't work while you're
to ensure that only working, tested, and secure programs are placed for public consumption.
On my Red Hat Linux system, I created a directory /var/www/html/re and copied the
modules Restrictionmap.pm, Rebase.pm, and SeqFileIO.pm there. On your system and
directory and those module files are suitable for your web server's configuration.
I then copied my CGI program webrebase1 into my CGI directory (on my system,
may vary depending on the operating system and web server that you are using.)
you've been using, and it's likely to work.
created in your web server's CGI directory (/var/www/cgi-bin on my Linux system running an
Apache web server). So, another thing to check is whether you have enough space for any
files your programs may create in your web space.
CGI.pm module.
the form and hit the Submit Query button.
form is one long print statement. The list of things to print is composed mostly of calls to
documentation on www.perldoc.org or by typing perldoc CGI at a command prompt.
Here are the CGI functions called but not seen in the earlier programs:
h1('<font color=orange>Restriction Maps on the Web</font>')
This is a header, as seen previously; however, it includes a color directive for the font.
start_multipart_form

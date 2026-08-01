#!/usr/bin/perl
You also usually make the program executable, using the chmod program:
chmod 755 this_program
program to run it. So, if you're in the same directory as the program, you can type 
./this_program or, if the program is in a directory that's included in your $PATH or $path
variable, you can type this_program.
[1]
[1] $PATH is the variable used for the shells sh, bash, and ksh; $path is the variable used for csh, tcsh, and
so on.
window may be a little confusing. For instance, the bash shell on my Linux system gives the
error message:
bash: ./my_program: No such file or directory
in two cases: if there really is no program called my_program in the current directory, or if the
first line of my_program has incorrectly given the location of Perl. So watch for that, especially
when running programs from CPAN that may have different pathnames for Perl embedded in
their first lines. Also, if you type my_program, you may get the error message:
bash: my_program: command not found
directory! The problem is probably that your $PATH or $path variable doesn't include the
current directory, so that the system isn't even looking in the current directory for the
program. In this case, change the $PATH or $path variable (depending on which shell you're
using); or just type ./my_program instead of my_program.
B.5.2 Running Perl Programs on the Macintosh
On Macs, the recommended way to save Perl programs is as "droplets." The MacPerl

documentation gives the simple instructions. Basically, you open the Perl program with the
MacPerl application and then choose Save As and select the Type option Droplet.
You can drag and drop a file onto a droplet in order to use the file as input (via the @ARGV
array).
Perl programs from the command line as just described for Unix and Linux systems.
B.5.3 Running Perl Programs on Windows
PATH variable specifying folders in which the system looks for programs; this is modified by
the Perl installation process to include the path to the folder for the Perl application, usually 
PATH variable, you can type the complete pathname to the program, e.g., perl
c:\windows\desktop\my_program.pl.

B.6 Finding Help
browser at http://www.ncbi.nlm.nih.gov (the National Center for Biotechnology Information)
and http://www.ebi.ac.uk/ (the European Bioinformatics Institute) for two of the biggest
sites for Perl and bioinformatics.
fine with the (free) online documentation, but if you end up doing a lot of Perl programming, 
beginner navigate, by means of tutorial documents.

Colophon 
topics, breathing personality and life into potentially dry subjects.
The animal on the cover of Mastering Perl for Bioinformatics is a North American bullfrog (
native habitat as Asia, Europe, and Hawaii.
tympanum) relative to the size of the eye.
American bullfrog threatens to drive other frog species to extinction.
The generic name (rana) comes from the Latin for frog, while the species name (catesbeiana)
plants, birds, reptiles, insects, and frogs.
the proofreader, for Mastering Perl for Bioinformatics. Jane Ellin and Colleen Gorman provided
assistance. John Bickelhaupt wrote the index.
produced the cover layout with QuarkXPress 4.1 using Adobe's ITC Garamond font.
icons were drawn by Christopher Bing. This colophon was written by Reg Aubry.


& (ampersand)
   && (logical and) operator  
   (bitwise and) operator  
< and > (angle brackets)
   > (arrow operator)  
   >> right shift operator  
   <> line input operator  
   << left shift operator  
* (asterisk) quantifier  
@ (at sign)  
@INC array  
-- (autodecrement operator)  
\ (backslash)
   escaping metacharacters  
   metasymbols, use in  
\@ (backslash-at)  
! (bang)
   ! (logical negation) operator  
   !~ (binding) operator  
   #! (shebang) notation  
!~ (binding operators)  
^ (caret)  
   metacharacter in regular expressions  
/i (case-insensitive) matching  
:// (colon-slashes)  
{} (curly braces)  2nd  
{} (curly braces) quantifier  
{} (curly braces)
   dereferencing and  
-w flag  
$flag variable  
$ (dollar sign)  
   $_ variables  
   metacharacter  
. (dot)
   character wildcard  
   current directory)  
   string operator  
:: (double colons) in module names  
= (equal sign)
   =~ (pattern binding) operator  
   => (syntactic sugar symbol)  
/ (forward slash)  
() (parentheses)  
%genetic_code hash  
% (percent sign)  
++ (autoincrement) operator  
+ (plus sign) quantifier  
? (question mark), in quantifiers  
" (quotes, double) in strings  
' (quotes, single) in strings  
; (semicolon), ending Perl statements  
#! (shebang notation)  
[ ] (square brackets)  
_dbh  
| (vertical bar)
   (bitwise OR) operator  
   || (logical or) operator  
   alternation  
@ARGV arrays  
^ (caret)

   bitwise xor operator  
24-bit color  

abstraction  
accessor methods  
   Gene2.pm  
algorithms  [See also string algorithms]
   border conditions and  
   data structures and  
   references  
alternation  
and operator
   bitwise and (&) operator  
   logical and  
       control flow, using for  
angle operator  
anonymous arrays  
anonymous data  
anonymous hashes  
anonymous referents  
approximate string matching  
arguments  
arithmetic operators  
arrays  2nd  
   @ARGV  
   anonymous arrays  
   of arrays  
   elements, specifying  
   matrices  
   references to  
   sparse arrays  
   as subroutine arguments  
   two-dimensional arrays  
arrow notation  
arrow operator (\>)  
assignment  
   scalar and list context  
assignment operators  
at sign (@)  
attributes  2nd  
   graphics output, storing in  
   key/value pairs  
attributes (databases)  
autoincrement and autodecrement operators  
AUTOLOAD subroutine  
   accessors  
   arguments  
   FileIO.pm  
   get_ and set_  
   mutators  
   speeding up the code  
   writing methods using  

backslash-at (\@)  
base 16 (hexadecimal) numbers  
base 8 (octal) numbers  
base class  
bases, changing to reverse complements  
binary (base 2) numbers  
bind variables  
binding operators  
   !~  
bioinformatics  
Bioperl  2nd  
   bptutorial.pl  
   documentation  2nd  
   history  
   installing  
   modules  
   object-oriented style  
   objects  
   problems  
   testing  
   test 1  
   test 2  
   test 3  
   test 4  
Bioperl modules  2nd  
bitmaps  
bitwise operators  
   & (bitwise and)  
bless function  
blocks  
body tags  
border conditions  
Boutell, Thomas  
bptutorial.pl  
browsers  
built-in functions, Perl  

candidate keys  
capturing in patterns  
caret (^)  
Carp module  2nd  
case-insensitive matching  
CERN  
CGI (Common Gateway Interface)  2nd  
   CGI.pm  2nd  
       functions  
       using  
   programs  
       checking syntax  
       error logs  
       installing  
       testing  
       writing  
   scripts  
   webrebase1 program  
chaining, logical operators  
character classes  
class data  
class inheritance  2nd  
Class::Struct  
classes  2nd  
   base class  
   documentation with POD  
   example of a Perl class  
   using  
client-server architecture  
clone constructor  
close (system call)  
closures  2nd  
CMYK  
codon2aa subroutine  
colon and forward slashes (://)  
color tables  
colorAllocate method  
command-line
   input files, naming on  
   interface to SQL  
commands
   interpretation line  
comments  
Common Gateway Interface  [See CGI]
complex (or imaginary) numbers  
complex data structures  2nd  
   dereferencing  
   hashes with array values  
   printing  
Comprehensive Perl Archive Network  [See CPAN]
computer graphics  [See graphics]
concatenating strings  
conditional statements  
   expressions in loops  
connect method  
constructor methods  
   FileIO.pm  
constructors
   clone  
   Gene.pm  
context  

control flow
   logical operators, using for  
copying
   arrays  
CPAN (Comprehensive Perl Archive Network)  
create database command  
create table command  
croak function  
croak subroutine  
curly braces ( {} )  2nd  
   dereferencing and  
current directory  
cut sites  

data compression and graphics file formats  
data redundancy  
data structures  2nd  3rd  [See also complex data structures]
data types  2nd  
Data::Dumper module  
databases  2nd  3rd  [See also Perl DBD; Perl DBI; SQL]4th  
   administration  
       adding users  
       backups  
       reloading  
   create database command  
   create table command  
   design  
   drop command  
   insert command  
   installation  
   popular versions  
   relational databases  
   stored procedures  
   tab-delimited input files  
   transactions  
   updates  
DBD::MySQL  
_dbh  
DBM files and hashes  
DBMSs (database management systems)  
   SQL and  
decimal numbers  
declarative programming  
decrementing variables  
defined and undefined values  
defined function  
dereferencing  
   complex data structures  
derived class  
DESTROY subroutine  
die function  
disconnect call  
do-until loops  
do-while loops  
documentation, Perl operators (perlop)  
dollar sign ($)  
dot (.) string operator  
double colons (::) in module names  
downloading Perl  
DPI  
_drawmap_jpg method  
_drawmap_png method  
_drawmap_text method  
drop command  
dump command (databases)  
dynamic programming  

edit distance  
else statements  
elsif statements  
em( ) function  
email  
encapsulation  2nd  
end_form function  
end_html function  
entity integrity  
entity-relationship modeling  
error messages
   directing to STDERR  
"exclusive-OR" operator (xor)  2nd  
execute method  
exponential notation  

false or true value, evaluating with conditionals  
FASTA header  
file test operators  
filehandles  
   output  
FileIO.pm  
   AUTOLOAD method  
   constructor method  
   read method  
   stat and localtime functions  
   test program  
   write method  
files
   directing output to  
   graphics formats  2nd  
   input from  
       named on command line  
   opening  
first normal form  
$flag variable  
floating-point numbers  
for loops  
foreach loops  
foreign keys  
format function  
formatting output using printf  
forward slash (/)  
fractions  
FTP  
functional dependencies  
functions, built-in  

garbage collection  
gd graphics library  2nd  
GD.pm  2nd  
   color table manipulation  
   compatible graphics file formats  
   installing  
   Restrictionmap.pm, adding graphics to  
   using  
GD::Graph module  2nd  
gd1.pl program  
gd2.pl program  
Gene.pm  
   constructor method  
   test program  
Gene1.pm  
Gene2.pm  
   accessor and mutator methods  
   new method  
   test program  
Gene3.pm  
   AUTOLOAD  [See AUTOLOAD subroutine]
   test program  
genetic variability and string matching  
Geneticcode.pm  
get_  
get_bionetfile method  
get_dbmfile method  
get_graphic method  
get_mode method  
get_recognition_sites method  2nd  
get_regular_expressions method  2nd  
GIF (Graphic Interchange Format)  
Gimp (GNU Image Manipulation Program)  
global variables  
graphics  
   applying color  
   file formats  2nd  
       data compression  
       GD compatible  
   graphics primitives  
   graphs, creating  
   methods  
   requirements for  
   vector graphics  
graphics data, storage in scalar  
graphics output, storing in object attributes  
greedy matching  

hard references  
hashes  2nd  3rd  
   %genetic_code  
   anonymous hashes  
   hash keys  
   references to  
   use in Perl as objects  
   with array values  
head tags  
header fields  
hexadecimal (base 16) numbers  
higher dimensional matrices  
home relations  
homologs database  
homologs.getdata program  
homologs.load program  
homologs.tabs program  
hostname  
HTML (Hypertext Markup Language)  
   directives  
   tags  
   web page example  
HTTP (Hypertext Transport Protocol)  
http://  
hypertext links  
Hypertext Markup Language  [See HTML]
Hypertext Transport Protocol  [See HTTP]

if statements  
ImageMagick and Image::Magick module  
imaginary numbers  
incrementing variables  
indexing
   scalar values in arrays  
inheritance  2nd  
input
   from files  
       named on command line  
   STDIN (standard input)  
insert command  
   alternatives to  
instance of a class  
integers  2nd  
Internet  
Internet addresses  
IP addresses  
is_ methods  

JPEG (Joint Photographic Experts Group)  2nd  
   outputting data as  

key/value pairs  2nd  3rd  
keys
   databases  
   primary keys  2nd  

left shift operator (<<)  
libraries  
line input operator (<>)  
Linux
   compiling Perl from source  
   installing Perl binaries on  
   Perl programs, running on  
list context  
load utility (SQL)  
local variables  
localtime function  
logical operators, using for control flow  
loops  

Macintosh, running Perl programs on  
MacOS X, specifying input files on command line  
_mapgraphics attribute  
matrices  
   dynamic programming  
   higher dimensional matrices  
matrix  
maximal (greedy) matching  
memory management, cleaning up unused objects  
metacharacters  
metasymbols  
methods  2nd  
   accessor methods  
   arrow notation and  
   AUTOLOAD and  
   constructor methods  
   mutator methods  
   Rebase class  
       parse_rebase  
minimal matching  
modules  2nd  3rd  
   advantages  
   Carp module  
   colons in module names  
   CPAN modules  
   defining  
   exporting names  
   Geneticcode.pm  
   storing  
mutators  2nd  
   Gene2.pm  
my  
my variables  
MySQL  2nd  
_mysql  
MySQL
   multithreading  
   Perl DBD driver for  

named fields  
names, scalar variables  
namespace collisions  
namespaces  
   capitalization  
new method  
   Gene1 class  
   Gene2.pm  
normal forms  
normalization  
not operator  
numbers
   floating-point  
   as scalar values  

object-oriented (OO) programming  
object-oriented programming  2nd  
objects  2nd  
   clearing from memory  
   hash data structures  
   instance of a class  
   representation as hashes  
octal (base 8) numbers  
open system call  
opening files  
operators  
   arithmetic  
   assignment  
   binding  
   bitwise  
   context and  
   file test  
   logical
       conditionals and  
   precedence of  
   string  
or operator
   | (bitwise OR)  
   logical or  
       control flow, using for  
output
   directing to STDOUT, STDERR and files  
   functions for  
output, formatting with printf  

package declaration  
packages  
palettes  
paragraph tags  
param( ) function  
parent class  
parse_ methods  
parse_rebase method  
parse_rebase program  
passing by reference  
passing references to subroutines  
pathnames on the Web  
patterns (and regular expressions)  
   binding operators  
   metacharacters  
   metasymbols  
   modifiers  
percent sign (%)  
Perl  
   arrays  [See arrays]
   assignment  
   built-in functions  
   command interpretation  
   comments  
   compiling from source  
   conditional statements
       logical operations and  
   documentation  
   downloading  
   finding help  
   hashes  [See hashes]
   input/output  
   installing  
       binary vs. source code  
   loops  
   object-oriented programming  
   operators  [See operators]
   regular expressions  
   running programs  
   scalar and list context  
   scalar values  
   statements
       blocks and  
   subroutines  
   variables
       scalar  
   versions  
Perl DBD (DataBase Dependent) modules  
   installing and configuring  
Perl DBI (DataBase Independent) module  2nd  
   connect method  
   disconnect method  
   examples  
   execute method  
   installing and configuring  
   loading the module  
   prepare method  
   SQL queries  
   tab-delimited files, reading in to a database  
PERL5LIB environmental variable  2nd  
perldoc command  

perlmod  
perlmodlib  
perlop documentation  
picture element  
pixels  
plain old documentation  [See POD]
PNG (Portable Network Graphics)  2nd  
   outputting data in  
POD (plain old documentation)  
positions in arrays  
precedence
   logical operators  
   operator  
primary keys  2nd  3rd  
primitives  
print function  
printf function  2nd  
printing complex data structures  
programming
   declarative programming  
   design phase  
   documentation  
   object-oriented (OO) programming  
   Perl language, summary  
   web programming  
programs, running  
put_ methods  

quantifiers  
   maximal and minimal  
quotes  

raster images  
rational numbers  
ratios  
read method  
Rebase (Restriction Enzyme Database)  
Rebase dynamic web pages  
Rebase.pm  
   attributes  
   methods  
       parse_rebase  
   Rebase object, creating  
   testing  
RebaseDB.pm  
   analysis  
   testing program  
recognition sites, mapping  2nd  
ref function  
references  2nd  
   to arrays  
   to hashes  
   passing to subroutines  
   to references  
   returning from subroutines  
   to subroutines  
   symbolic vs. hard  
   within blocks  
referential integrity  
referents  
   anonymous referents  
regular expressions  
relational databases  [See databases]
relational model  
relations  
repeating strings (x operator)  
request  
request method  
response  
Restriction class
   creating  
   planning  
restriction enzymes  
restriction maps  
   creating  
Restriction.pm  
   documentation  
   initializing objects  
Restrictionmap.pm  
   graphics enhancements  
   JPEG output, adding  
   Restrictionmap class  
   testing  
returning references from subroutines  
reverse complements, changing bases into  
RGB  
right shift operator (>>)  
rows  

s/// (substitution) operator  
scalar context  
   arrays in  
scalar values  
   assigning to arrays  
   assigning to scalar variables  
   numbers  
   strings  2nd  [See also strings]
scalar variables  
   assigning scalar values to  
scalars  
   storing graphics data in  
scheme  
scientific (exponential) notation  
scripts (CGI)  
second normal form  
select command  
SeqFileIO.pm  
   test program  
SequenceIO module  
SequenceIO.pm  2nd  
set_  
software reuse  
sparse arrays  
sprintf function  
SQL (Structured Query Language)  2nd  3rd  [See also databases]
   commands  
       create database  
       create table  
       drop  
       insert  
   load utility  
   queries  
       bind variables  
   select command  
SQL2  
SQL3  
square brackets ([ ])  
start_multipart_form function  
stat function  
statements  
status line  
STDERR filehandle  
STDIN filehandle  
STDOUT filehandle  
stored procedures  
string algorithms  
strings  
   binding operators  
   capturing matched patterns in  
   formatting (sprintf function)  
   matching  
       genetic variability and  
   operators  
   substituting characters in (tr/// operator)  
subroutines  2nd  
   passing data to
       by reference  
   passing references to  
   references to  
   returning references from  

substitution (s///) operator  
SUPER class  
superclass  
symbol tables  
symbolic references  
syntactic sugar symbol (=>)  
system calls, open and close  

tab-delimited input files  
   SQL load utility and  
tables  
   creating  
   populating  
tags  
testRebaseDB program  
title tags  
tr/// (transliteration) operator  
transactions  
transliteration (tr///) operator  
true or false value, evaluating with conditionals  
truecolor  
tuples  
two-dimensional arrays  
two-dimensional matrices  

undefined values  2nd  
unique identifiers  
Unix
   compiling Perl from source  
   installing Perl binaries on  
   Perl programs, running on  
   specifying input files on command line  
unless statements  
update anomalies  
URI::URL modules  
URLs (Uniform Resource Locators)  
use lib directive  2nd  
use strict  
   AUTOLOAD, bypassing with  
use strict directive  

variables
   scalar  
       assigning scalar values to  
   testing and changing value in loops  
vector graphics  

warn function  
warnings flag  
Web  
web browsers  
web pages  
   building  
   directory locations  
   example  
web programming  
web servers  
webrebase1  
   analysis  
   installing  
while loops  
Windows
   Perl programs, running on  
Windows systems
   specifying input files on command line  
World Wide Web  [See Web]
write function  
write method
   FileIO.pm  

x operator  
x string operator  
xor operator  

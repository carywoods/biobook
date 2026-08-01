use strict. They also serve as the basic mechanism for defining object-oriented
classes.

1.2 Why Perl Modules?
position the pipettes, hydraulic injection devices, and computer guidance for all these
systems.
Subroutines divide a large programming job into more manageable pieces. Modern
macros in other programming languages.
rest of the program. This is known as encapsulation.
oftware encapsulation and reuse. Software encapsulation and reuse are fundamental to
object-oriented programming.
the second one appended to the end of the first:
sub DNAappend {
       my ($dna, $tail) = @_;
       return($dna . $tail);
}
This subroutine can be used as follows:
my $dna = 'ACCGGAGTTGACTCTCCGAATA';
my $polyT = 'TTTTTTTT';
print DNAappend($dna, $polyT);
If you wish, you can also define subroutines polyT and polyA like so:
sub polyT {
   my ($dna) = @_;
   return DNAappend($dna, 'TTTTTTTT');
}

sub polyA {
   my ($dna) = @_;
   return DNAappend($dna, 'AAAAAAAA');
}
particular problem.
In my projects, I gather subroutine definitions into separate files called libraries,
[1] or modules,
which let me collect subroutine definitions for use in other programs. Then, instead of copying
the subroutine definitions into the new program (and introducing the potential for inaccurate
copies or for alternate versions proliferating), I can just insert the name of the library or
This is an example of software reuse in action.
[1] Perl libraries were traditionally put in files ending with .pl, which stands for perl library; the term library is
reusable subroutines.
To fully understand and use modules, you need to understand the simple concepts of
uses package declarations to create its own namespace. These simple concepts are
examined in the next sections.

1.3 Namespaces
many programs, especially those in which only one default namespace is used.
Large programs often accidentally use the same variable name for different variables in
with each other and cause serious, hard-to-find errors. This situation is called namespace
collision. Separate namespaces are one way to avoid namespace collision.
identically-named variables interact in unwanted ways.
use of my to restrict the scope of a variable to its enclosing block (between matching curly
braces {}) and should be accustomed to using the directive use strict to require the use of
my for all variables. use strict and my are a great way to protect your program from
unintentional reuse of variable names. Make a habit of using my and working under use
strict.

1.4 Packages
helps prevent namespace collisions and lets you create modules.
effect. Here's a simple example:
$dna = 'AAAAAAAAAA';
package Mouse;
$dna = 'CCCCCCCCCC';
package Celegans;
$dna = 'GGGGGGGGGG';
In this snippet, there are three variables, each with the same name, $dna. However, they are
separately by the running Perl program.
The first line of the code is an assignment of a poly-A DNA fragment to a variable $dna.
Because no package is explicitly named, this $dna variable appears in the default namespace
main.
The second line of code introduces a new namespace for variable and subroutine definitions
Mouse namespace is brought into play. Note that the name of the namespace is capitalized;
should use is the default main.
Now that the Mouse namespace is in effect, the third line of code, which declares a variable,
$dna, is actually declaring a separate variable unrelated to the first. It contains a poly-C
fragment of DNA.
also called $dna, that stores a poly-G DNA fragment.
To use these three $dna variables, you need to explicitly state which packages you want the
variables from, as the following code fragment demonstrates:
print "The DNA from the main package:\n\n";
print $main::dna, "\n\n";
print "The DNA from the Mouse package:\n\n";
print $Mouse::dna, "\n\n";
print "The DNA from the Celegans package:\n\n";
print $Celegans::dna, "\n\n";
This gives the following output:
The DNA from the main package:
AAAAAAAAAA
The DNA from the Mouse package:
CCCCCCCCCC
The DNA from the Celegans package:
GGGGGGGGGG

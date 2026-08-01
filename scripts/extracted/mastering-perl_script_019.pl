use Bio::Seq;
        use Bio::SeqIO;
        $seqin = Bio::SeqIO->new( '-format' => 'EMBL' , -file =>
'myfile.dat');
        $seqout= Bio::SeqIO->new( '-format' => 'Fasta', -file =>
'>output.fa');
        while((my $seqobj = $seqin->next_seq(  ))) {
              print "Seen sequence ",$seqobj->display_id,", start of seq ",
                     substr($seqobj->seq,1,10),"\n";
              if( $seqobj->moltype eq 'dna') {
                  $rev = $seqobj->revcom;
                  $id  = $seqobj->display_id(  );
                  $id  = "$id.rev";
                  $rev->display_id($id);
                  $seqout->write_seq($rev);
               }
              foreach $feat ( $seqobj->top_SeqFeatures(  ) ) {
                 if( $feat->primary_tag eq 'exon' ) {
                    print STDOUT "Location ",$feat->start,":",
                          $feat->end," GFF[",$feat->gff_string,"]\n";
                 }
              }
         }
DESCRIPTION
      Bioperl is a set of Perl modules that represent useful
      biological objects. Some of the key objects represent:
      Sequences, features on sequences, databases of sequences,
      flat file representations of sequences and similarity
      search results.
      Because bioperl is formed from Perl modules, there are no
      actual useable programs in the distribution (this is not
      actually true.  In the scripts directory there are a few
      useful programs. But not a great deal...). You have to
      write the programs which use bioperl.
      It is very easy to write programs using the bioperl mod-
      ules, as a lot of the complex processing happens in the
      modules and not in the part of the program which you have
      to write. The idea is that you can connect up a number of
      the modules to do useful things. The synopsis above gives
      a simple script which uses bioperl. Stepping through this
      script, the lines mean the following things:
      ...
of this example.
After the typical use statements (needed to load the modules), such as:
use Bio::SeqIO;
the documentation has the following line in the example:
$seqin = Bio::SeqIO->new( '-format' => 'EMBL' , -file => 'myfile.dat');
This line calls the new method. new is the name typically used in OO Perl for the subroutine

the reference variable $seqin.
arrow (->), and finally the method name:
Bio::SeqIO->new
This is the syntax for calling methods. If you're just interested in using the class, not in
method).
Later in the biostart example you see the line:
while((my $seqobj = $seqin->next_seq(  ))) {
The call to the method next_seq is done as follows:
$seqobj = $seqin->next_seq(  )
Here, the Bio::SeqIO class object $seqin is being used to call the method next_seq in the
class Bio::SeqIO. Because $seqin was created as an object in the class Bio::SeqIO, it can
be used with arrow notation (->) to call a method in the class, without specifically mentioning
saved as $seqobj, a new object.
class. Both types of calls are accomplished with arrow notation.
Here's a new object being created in a class Myclass:
$myobject = Myclass->new(  );
Here's a method compute being called on that object:
$myobject->compute(  );
the methods are specified. Consider this line from the example:
$seqin = Bio::SeqIO->new( '-format' => 'EMBL' , -file => 'myfile.dat');
argument followed by the symbol => followed by a value for the argument. If this looks
sense that you'd pass your initial values to the object using hash notation.
now, if you just want to use this class, you'll need to pass your arguments to the new method
in the style just shown. Methods in a class usually pass arguments in this hash-like, key =>
value notation, but not always. If you use the syntax as shown in the documentation, your
code will be fine.
One advantage to using a hash for arguments is that the arguments can be given in any
list of scalars as arguments to a subroutine.
sufficient syntax information to use a Perl OO module. The next section shows how to start
pulling it all together.
[

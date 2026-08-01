use strict;
use warnings;
use Carp;
# Class data and methods
{
   # A list of all attributes with default values.
   my %_attributes = (
       #    key   = restriction enzyme name
       #    value = space-separated string of recognition sites => regular
expressions
       _rebase      => { },    # A Rebase.pm object
       _sequence    => '',     # DNA sequence data in raw format (only
bases)
       _enzyme      => '',     # space separated string of one or more
enzyme names
       _map         => { },    # hash: enzyme names => arrays of locations
       _graphictype => 'text', # one of 'text' or 'png' or some other
       _graphic     => '',     # a graphic display of the restriction map
   );
   # Return a list of all attributes
   sub _all_attributes {
       keys %_attributes;
   }
}
Notice also that no AUTOLOAD mechanism is provided.
%_attributes that adds the new attribute _graphictype to indicate the type of graphic (at
first, this will be "text"), and the new attribute _graphic as a simple scalar.
an extra call to the Perl join function.

decision to store the image data as a scalar gives the most flexibility for future development.
%_attributes data structure that appears in the same block with it. The other methods in
derived class Restrictionmap and will work fine.
Next, come the methods that add the graphics capability to the class:
sub get_graphic {
   my($self) = @_;
   # If the graphic is not stored, calculate and store it
   unless($self->{_graphic}) {
       unless($self->{_graphictype}) {
           croak 'Attribute graphictype not set (default is "text")';
       }
       # if graphictype is "xyz", method that makes the graphic is
"_drawmap_xyz"
       my $drawmapfunctionname = "_drawmap_" . $self->{_graphictype};
       # Calculate and store the graphic
       $self->{_graphic} = $self->$drawmapfunctionname;
   }
   # Return the stored graphic
   return $self->{_graphic};
}
only calculate the graphics for an object the first time the graphic is requested; it's then saved
in the _mapgraphic attribute for subsequent calls.
ahead and add it here as well.
with the get_enzyme_map method. The appropriate annotation is added to the @annotation
array. The resulting annotation is then formatted for output and returned:
#
# Methods to output graphics in text format
#
sub _drawmap_text {
   my($self) = @_;
   my @annotation = ();
   push(@annotation, _initialize_annotation_text($self->get_sequence));
   foreach my $enzyme ($self->get_enzyme_names) {
       _add_annotation_text(
annotation, $enzyme,

$self->get_enzyme_map($enzyme));
   }
   # Format the restriction map as sequence and annotation
   my @output = _formatmaptext(50, $self->get_sequence, @annotation);
   # Return output as a string, not an array of lines
   return join('', @output);
}
#  Make a blank string of the same length as the given sequence string
sub _initialize_annotation_text {
   my($seq) = @_;
   return '' x length($seq);
separated by blank lines just for readability. Directly above the sequence lines are additional
additional annotation line is created to print these overlapping enzyme names. There's an
example of this in the program output following this discussion.
they say, it will be left as an exercise for the reader. Or, as one of my mathematics
you."
#   Add annotation to an annotation string
sub _add_annotation_text {
   my($array, $enz, @pos) = @_;
   # $array is a reference to an array of annotations
   # Put the labels for the enzyme name at the correct positions in the
annotation
   foreach my $location (@pos) {
       # Loop through all the annotation strings as necessary
       for( my $i = 0 ; $i < @$array ; ++$i ) {
           # If the annotation contains only space characters at that
position,
           # insert the annotation
           if(substr($$array[$i], $location-1, length($enz)) eq (' ' x
length($enz))){
              substr($$array[$i], $location-1, length($enz)) = $enz;
              last;
           # If the annotation collides, add it to the next annotation
string on the
           # next iteration of the "for" loop.
           # But first, if there is not another annotation string, make one
           }elsif($i == (@$array - 1)) {
               push(@$array, _initialize_annotation_text($$array[0]));
           }
       }
   }

}
# Sequence with annotation lines formatted for the page with line breaks
sub _formatmaptext {
   my($line_length, $seq, @annotation) = @_;
   my(@output) = ();
   # Split strings into lines of $line_length
   for ( my $pos = 0 ; $pos < length($seq) ; $pos += $line_length ) {
       # Print annotation on top of sequence, using reverse
       foreach my $string ( reverse ($seq, @annotation) ) {
           # Discard blank lines?
           # if ( substr($string, $pos, $line_length) !~ /[^ \n]/ ) {
           #     next;
           # }
           # Add line to output
           push(@output, substr($string, $pos, $line_length) . "\n");
       }
       # separate the lines
       push(@output,"\n");
   }
   # Return the merged annotation and sequence
   return @output;
}
=head1 Restrictionmap
Restrictionmap: Given a Rebase object, sequence, and list of restriction
enzyme
   names, return the locations of the recognition sites in the sequence
=head1 Synopsis
   use Restrictionmap;
   use Rebase;
   use strict;
   use warnings;
   my $rebase = Rebase->new(
       dbmfile => 'BIONET',
       bionetfile => 'bionet.212'
   );
   my $restrict = Restrictionmap->new(
       rebase => $rebase,
       enzyme => 'EcoRI',
       enzyme => 'HindIII',
       sequence => 'ACGAATTCCGGAATTCG',
       graphictype => 'text',
   );
  
   print "Locations are ", join ' ', $restrict->get_enzyme_map('EcoRI'),
"\n";
   print $restrict->get_graphic;
=head1 AUTHOR

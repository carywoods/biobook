#!/usr/bin/perl
# BeginPerlBioinfo.pm
# Utility module for "Beginning Perl for Bioinformatics" by James Tisdall
# Reconstructed from book source code

package BeginPerlBioinfo;
use strict;
use warnings;
use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(
    codon2aa
    dna2peptide
    extract_sequence_from_fasta_data
    get_file_data
    print_sequence
    revcom
    translate_frame
);

sub codon2aa {
  my($codon) = @_;
   
     if ( $codon =~ /TCA/i )   { return 'S' }   # Serine
  elsif ( $codon =~ /TCC/i )   { return 'S' }   # Serine
  elsif ( $codon =~ /TCG/i )   { return 'S' }   # Serine
  elsif ( $codon =~ /TCT/i )   { return 'S' }   # Serine
  elsif ( $codon =~ /TTC/i )   { return 'F' }   # Phenylalanine
  elsif ( $codon =~ /TTT/i )   { return 'F' }   # Phenylalanine
  elsif ( $codon =~ /TTA/i )   { return 'L' }   # Leucine
  elsif ( $codon =~ /TTG/i )   { return 'L' }   # Leucine
  elsif ( $codon =~ /TAC/i )   { return 'Y' }   # Tyrosine
  elsif ( $codon =~ /TAT/i )   { return 'Y' }   # Tyrosine
  elsif ( $codon =~ /TAA/i )   { return '_' }   # Stop
  elsif ( $codon =~ /TAG/i )   { return '_' }   # Stop
  elsif ( $codon =~ /TGC/i )   { return 'C' }   # Cysteine
  elsif ( $codon =~ /TGT/i )   { return 'C' }   # Cysteine
  elsif ( $codon =~ /TGA/i )   { return '_' }   # Stop
  elsif ( $codon =~ /TGG/i )   { return 'W' }   # Tryptophan
  elsif ( $codon =~ /CTA/i )   { return 'L' }   # Leucine
  elsif ( $codon =~ /CTC/i )   { return 'L' }   # Leucine
  elsif ( $codon =~ /CTG/i )   { return 'L' }   # Leucine
  elsif ( $codon =~ /CTT/i )   { return 'L' }   # Leucine
  elsif ( $codon =~ /CCA/i )   { return 'P' }   # Proline
  elsif ( $codon =~ /CCC/i )   { return 'P' }   # Proline
  elsif ( $codon =~ /CCG/i )   { return 'P' }   # Proline
  elsif ( $codon =~ /CCT/i )   { return 'P' }   # Proline
  elsif ( $codon =~ /CAC/i )   { return 'H' }   # Histidine
  elsif ( $codon =~ /CAT/i )   { return 'H' }   # Histidine
  elsif ( $codon =~ /CAA/i )   { return 'Q' }   # Glutamine
  elsif ( $codon =~ /CAG/i )   { return 'Q' }   # Glutamine
  elsif ( $codon =~ /CGA/i )   { return 'R' }   # Arginine
  elsif ( $codon =~ /CGC/i )   { return 'R' }   # Arginine
  elsif ( $codon =~ /CGG/i )   { return 'R' }   # Arginine
  elsif ( $codon =~ /CGT/i )   { return 'R' }   # Arginine
  elsif ( $codon =~ /ATA/i )   { return 'I' }   # Isoleucine
  elsif ( $codon =~ /ATC/i )   { return 'I' }   # Isoleucine
  elsif ( $codon =~ /ATT/i )   { return 'I' }   # Isoleucine
  elsif ( $codon =~ /ATG/i )   { return 'M' }   # Methionine
  elsif ( $codon =~ /ACA/i )   { return 'T' }   # Threonine
  elsif ( $codon =~ /ACC/i )   { return 'T' }   # Threonine
  elsif ( $codon =~ /ACG/i )   { return 'T' }   # Threonine
  elsif ( $codon =~ /ACT/i )   { return 'T' }   # Threonine
  elsif ( $codon =~ /AAC/i )   { return 'N' }   # Asparagine
  elsif ( $codon =~ /AAT/i )   { return 'N' }   # Asparagine
  elsif ( $codon =~ /AAA/i )   { return 'K' }   # Lysine
  elsif ( $codon =~ /AAG/i )   { return 'K' }   # Lysine
  elsif ( $codon =~ /AGC/i )   { return 'S' }   # Serine
  elsif ( $codon =~ /AGT/i )   { return 'S' }   # Serine
  elsif ( $codon =~ /AGA/i )   { return 'R' }   # Arginine
  elsif ( $codon =~ /AGG/i )   { return 'R' }   # Arginine
  elsif ( $codon =~ /GTA/i )   { return 'V' }   # Valine
  elsif ( $codon =~ /GTC/i )   { return 'V' }   # Valine
  elsif ( $codon =~ /GTG/i )   { return 'V' }   # Valine
  elsif ( $codon =~ /GTT/i )   { return 'V' }   # Valine
  elsif ( $codon =~ /GCA/i )   { return 'A' }   # Alanine
  elsif ( $codon =~ /GCC/i )   { return 'A' }   # Alanine
  elsif ( $codon =~ /GCG/i )   { return 'A' }   # Alanine
  elsif ( $codon =~ /GCT/i )   { return 'A' }   # Alanine
  elsif ( $codon =~ /GAC/i )   { return 'D' }   # Aspartic Acid
  elsif ( $codon =~ /GAT/i )   { return 'D' }   # Aspartic Acid
  elsif ( $codon =~ /GAA/i )   { return 'E' }   # Glutamic Acid
  elsif ( $codon =~ /GAG/i )   { return 'E' }   # Glutamic Acid
  elsif ( $codon =~ /GGA/i )   { return 'G' }   # Glycine
  elsif ( $codon =~ /GGC/i )   { return 'G' }   # Glycine
  elsif ( $codon =~ /GGG/i )   { return 'G' }   # Glycine
  elsif ( $codon =~ /GGT/i )   { return 'G' }   # Glycine
  else {
    print STDERR "Bad codon \"$codon\"!!\n";
    exit;
  }
}

sub dna2peptide {
  
  my($dna) = @_;

  use strict;
  use warnings;
  use BeginPerlBioinfo;     # see Chapter 6 about this module

  # Initialize variables
  my $protein = '';

  # Translate each three-base codon to an amino acid, and append to a protein 
  for(my $i=0; $i < (length($dna) - 2) ; $i += 3) {
    $protein .= codon2aa( substr($dna,$i,3));
  }

  return $protein;
  }

sub extract_sequence_from_fasta_data {

  my(@fasta_file_data) = @_;

  use strict;
  use warnings;

  # Declare and initialize variables
  my $sequence = '';

  foreach my $line (@fasta_file_data) {

    # discard blank line
    if ($line =~ /^\s*$/) {
      next;

    # discard comment line
    } elsif($line =~ /^\s*#/) {
      next;

    # discard fasta header line
    } elsif($line =~ /^>/) {
      next;

    # keep line, add to sequence string
    } else {
      $sequence .= $line;
    }
  }

  # remove non-sequence data (in this case, whitespace) from $sequence string
  $sequence =~ s/\s//g;

  return $sequence;
}

sub get_file_data {

  my($filename) = @_;

  use strict;
  use warnings;

  # Initialize variables
  my @filedata = ( );

  unless( open(GET_FILE_DATA, $filename) ) {
    print STDERR "Cannot open file \"$filename\"\n\n";
    exit;
  }

  @filedata = <GET_FILE_DATA>;

  close GET_FILE_DATA;

  return @filedata;
}

sub print_sequence {
  
  my($sequence, $length) = @_;

  use strict;
  use warnings;

  # Print sequence in lines of $length
  for ( my $pos = 0 ; $pos < length($sequence) ; $pos += $length  ) {
    print substr($sequence, $pos, $length), "\n";
  }
}

sub revcom {

  my($dna) = @_;

  # First reverse the sequence
  my($revcom) = reverse($dna);

  # Next, complement the sequence, dealing with upper and lower case
  # A->T, T->A, C->G, G->C
  $revcom =~ tr/ACGTacgt/TGCAtgca/;

  return $revcom;
}

sub translate_frame {

  my($seq, $start, $end) = @_;

  my $protein;

  # To make the subroutine easier to use, you won't need to specify
  #  the end point--it will just go to the end of the sequence
  #  by default.
  unless($end) {
    $end = length($seq);
  }

  # Finally, calculate and return the translation
    return dna2peptide ( substr ( $seq, $start - 1, $end -$start + 1 ) );
}

1;

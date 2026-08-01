use strict;
use warnings;
#use vars '$AUTOLOAD';
use Carp;
# Class data and methods
{
   # A list of all attributes with defaults and read/write/required/noinit
properties
   my %_attribute_properties = (
       _filename    => [ '',   'read.write.required'],
       _filedata    => [ [ ],  'read.write.noinit'],
       _date        => [ '',   'read.write.noinit'],
       _writemode   => [ '>',  'read.write.noinit'],
       _format      => [ '',   'read.write'],
       _sequence    => [ '',   'read.write'],
       _header      => [ '',   'read.write'],
       _id          => [ '',   'read.write'],
       _accession   => [ '',   'read.write'],

   );
       
   # Return a list of all attributes
   sub _all_attributes {
           keys %_attribute_properties;
   }
   # Check if a given property is set for a given attribute
   sub _permissions {
       my($self, $attribute, $permissions) = @_;
       $_attribute_properties{$attribute}[1] =~ /$permissions/;
   }
   # Return the default value for a given attribute
   sub _attribute_default {
           my($self, $attribute) = @_;
       $_attribute_properties{$attribute}[0];
   }
   my @_seqfileformats = qw(
       _raw
       _embl
       _fasta
       _gcg
       _genbank
       _pir
       _staden
   );
   sub isformat {
        my($self) = @_;
       for my $format (@_seqfileformats) {
           my $is_format = "is$format";
           if($self->$is_format) {
               return $format;
           }
       }
       return 'unknown';
   }
}
redefining the %_attribute_properties hash and the methods in the block that access the
relate specifically to sequence datafiles:
_format
The format of the sequence datafile, such as FASTA or GenBank
_sequence
The sequence data extracted from the sequence datafile as a scalar string
_header
The header part of the annotation; defined somewhat loosely in this module
_id
The ID of the sequence datafile, such as a gene name or other identifier
_accession

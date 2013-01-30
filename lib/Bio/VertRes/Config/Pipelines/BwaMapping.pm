package Bio::VertRes::Config::Pipelines::BwaMapping;

# ABSTRACT: Base class for the BWA mapper

=head1 SYNOPSIS

Base BWA for the smalt mapper. 
   use Bio::VertRes::Config::Pipelines::BwaMapping;

   my $pipeline = Bio::VertRes::Config::Pipelines::BwaMapping->new(
     database => 'abc',
     reference => 'Staphylococcus_aureus_subsp_aureus_ABC_v1',
     limits => {
       project => ['ABC study'],
       species => ['EFG']
     },

     );
   $pipeline->to_hash();

=cut

use Moose;
extends 'Bio::VertRes::Config::Pipelines::Mapping';

has 'slx_mapper'     => ( is => 'ro', isa => 'Str', default => 'bwa' );
has 'slx_mapper_exe' => ( is => 'ro', isa => 'Str', default => '/software/pathogen/external/apps/usr/local/bwa-0.6.1/bwa' );

__PACKAGE__->meta->make_immutable;
no Moose;
1;


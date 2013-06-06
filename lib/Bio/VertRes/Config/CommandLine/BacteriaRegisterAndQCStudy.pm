package Bio::VertRes::Config::CommandLine::BacteriaRegisterAndQCStudy;

# ABSTRACT: Create config scripts to map helminths

=head1 SYNOPSIS

Create config scripts to map helminths

=cut

use Moose;
use Bio::VertRes::Config::Recipes::BacteriaRegisterAndQCStudy;
with 'Bio::VertRes::Config::CommandLine::ReferenceHandlingRole';
extends 'Bio::VertRes::Config::CommandLine::RegisterAndQCStudy';

has 'database' => ( is => 'rw', isa => 'Str', default => 'pathogen_prok_track' );

override 'run' => sub {
    my ($self) = @_;

    ( ( ( defined($self->available_references) && $self->available_references ne "" ) || ( $self->reference && $self->type && $self->id ) )
          && !$self->help ) or die $self->usage_text;

    return if(handle_reference_inputs_or_exit( $self->reference_lookup_file, $self->available_references, $self->reference ) == 1);

    my %mapping_parameters = %{$self->mapping_parameters};
    $mapping_parameters{'assembler'} = $self->assembler;
    Bio::VertRes::Config::Recipes::BacteriaRegisterAndQCStudy->new( \%mapping_parameters )->create();

    $self->retrieving_results_text;
};

override 'register_and_qc_usage_text' => sub {
    my ($self) = @_;
    return <<USAGE;
Usage: bacteria_register_and_qc_study [options]
Pipeline to register and QC a bacteria study.

# Search for an available reference
bacteria_register_and_qc_study -a "Stap"

# Register and QC a study
bacteria_register_and_qc_study -t study -i 1234 -r "Staphylococcus_aureus_subsp_aureus_EMRSA15_v1"

# Register and QC a single lane
bacteria_register_and_qc_study -t lane -i 1234_5#6 -r "Staphylococcus_aureus_subsp_aureus_EMRSA15_v1"

# Register and QC a file of lanes
bacteria_register_and_qc_study -t file -i file_of_lanes -r "Staphylococcus_aureus_subsp_aureus_EMRSA15_v1"

# Register and QC a single species in a study
bacteria_register_and_qc_study -t study -i 1234 -r "Staphylococcus_aureus_subsp_aureus_EMRSA15_v1" -s "Staphylococcus aureus"

# Register and QC a study assembling with SPAdes
bacteria_register_and_qc_study -t study -i 1234 -r "Staphylococcus_aureus_subsp_aureus_EMRSA15_v1" -assembler spades

# This help message
bacteria_register_and_qc_study -h

USAGE
};



__PACKAGE__->meta->make_immutable;
no Moose;
1;
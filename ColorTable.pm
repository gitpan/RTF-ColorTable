package RTF::ColorTable;

require 5.005_62;
use strict;
use warnings::register qw( RTF::ColorTable );

require Exporter;
use RTF::Group 1.10;

our @ISA = qw( RTF::Group Exporter );
our @EXPORT_OK = ( );
our @EXPORT = qw(
	
);
our $VERSION = '1.00';

use Carp;

sub _name_slot

# Generate slot names for properties

  {
    my $property = shift;
    return join("::", __PACKAGE__, $property);
  }


sub _initialize

# Initialize the RTF::ColorTable object

{
    my $self = shift;
    $self->SUPER::_initialize();
    $self->{ _name_slot 'COUNT'} = 0;
    $self->{ _name_slot 'TABLE'} = [];
    $self->append( '\colortbl;' );
}

sub find_rgb
  {
    my ($self, $red, $green, $blue) = @_;

    my $i = $self->{ _name_slot 'COUNT'};
    while ($i)
    {
      $i--;
      if (
	  ($self->{_name_slot 'TABLE'}->[ $i ]->[0] == $red) and
	  ($self->{_name_slot 'TABLE'}->[ $i ]->[1] == $green) and
	  ($self->{_name_slot 'TABLE'}->[ $i ]->[2] == $blue) )
	{
	  return 1+$i;
	}
    }

    return;
  }

sub add_rgb
  {
    my ($self, $red, $green, $blue) = @_;

    foreach my $value ($red, $green, $blue)
    {
	croak "Invalid color code: \`$value\'",
	  if (($value<0) or ($value>255) or ($value =~ m/\D/));
    }

    my $color = $self->find_rgb( $red, $green, $blue );
    if ($color)
      {
	if (warnings::enabled)
	  {
	    warnings::warn "Duplicate color was not added";
	  }
	return $color;
      }

    $self->{_name_slot 'TABLE'}->[ $self->{ _name_slot 'COUNT'}++ ] = 
      [$red, $green, $blue];

    $self->append( '\red'.$red, '\green'.$green, '\blue'.$blue, ';' );

    return $self->{ _name_slot 'COUNT' };
  }

sub is_valid

# Tests if the color is valid.

  {
    my ($self, $color) = @_;

    return ! ( ($color<0) or ($color > $self->{_name_slot 'COUNT'}) or
	 ($color =~ /\D/) )
  }

sub count

# Returns the number of colors defined in the table.

  {
    my ($self) = @_;
    return ($self->{_name_slot 'COUNT'});
  }



1;
__END__

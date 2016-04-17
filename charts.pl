#!/bin/perl
use strict;
use warnings;
use Data::Dumper;
use Chart::Gnuplot;
use HTML::Table;
use List::Util qw( max );
#
# DADOS
#

#Quantidade de outputs ignorados
my $IGNORAR = 10;
my %info = ();

my @folders_progs = `ls -l outputs/ | grep '^d' | awk '{print \$9}'`;
for my $prog (@folders_progs) {

	chomp $prog;
	my @folders_flags = `ls -l -tr outputs/$prog/ | grep '^d' | awk '{print \$9}'`;

	for my $flag (@folders_flags) {

		chomp $flag;
		my @time_values = ();
		my @cpu_values = ();
		my @gpu_values = ();
		my @memory_values = ();
		my @files = `ls outputs/$prog/$flag`;	

		for my $file (@files) {
			chomp $file;
			open(my $fh, "<", "outputs/$prog/$flag/$file") or die "Could not open file '$file' $!";

			my $i = 0;
			while (my $row = <$fh>) {
				chomp $row;

				if($row =~ /Total time:/) {
					$_ = $row;
					s/.+?([0-9\.]+)s.*/$1/;
					$info{$prog}{$flag}{$file}{time} = $_;
					next;
				}

				if($row =~ /J consumed/) {
					$_ = $row;
					s/.+?([0-9\.]+)J.*/$1/;
					$info{$prog}{$flag}{$file}{$i} = $_;
					$i++;
				}
			}
			close($fh);

			push @time_values, $info{$prog}{$flag}{$file}{time};
			push @cpu_values, $info{$prog}{$flag}{$file}{1};
			push @gpu_values, $info{$prog}{$flag}{$file}{2};
			push @memory_values, $info{$prog}{$flag}{$file}{3};
		}

		@time_values = sort @time_values;
		splice @time_values, 0, $IGNORAR;
		splice @time_values, -$IGNORAR, $IGNORAR;
		$info{$prog}{$flag}{time_mean} = sprintf("%.3f",(eval join '+', @time_values) / (scalar(@time_values)));

		@cpu_values = sort @cpu_values;
		splice @cpu_values, 0, $IGNORAR;
		splice @cpu_values, -$IGNORAR, $IGNORAR;
		$info{$prog}{$flag}{cpu_mean} = sprintf("%.3f",(eval join '+', @cpu_values) / (scalar(@cpu_values)));

		@gpu_values = sort @gpu_values;
		splice @gpu_values, 0, $IGNORAR;
		splice @gpu_values, -$IGNORAR, $IGNORAR;
		$info{$prog}{$flag}{gpu_mean} = sprintf("%.3f",(eval join '+', @gpu_values) / (scalar(@gpu_values)));

		@memory_values = sort @memory_values;
		splice @memory_values, 0, $IGNORAR;
		splice @memory_values, -$IGNORAR, $IGNORAR;
		$info{$prog}{$flag}{memory_mean} = sprintf("%.3f",(eval join '+', @memory_values) / (scalar(@memory_values)));
	}
}

#
# GRÁFICO E TABELA
#
mkdir "charts" unless(-d "charts");	
for my $prog (@folders_progs) {

	chomp $prog;

	my @flags = ();
	my @time_values = ();
	my @cpu_values = ();
	my @gpu_values = ();
	my @memory_values = ();

	for my $flag (sort keys %{$info{$prog}}) {
		push @time_values, $info{$prog}{$flag}{time_mean};
		push @cpu_values, $info{$prog}{$flag}{cpu_mean};
		push @gpu_values, $info{$prog}{$flag}{gpu_mean};
		push @memory_values, $info{$prog}{$flag}{memory_mean};
		push @flags, $flag;
	}
	
	my $max_energy = max(@cpu_values) + max(@gpu_values) + max(@memory_values);
	my $max_time = max(@time_values);

	#
	# TABELA
	#
	my $table = new HTML::Table(
		-class=>'table table-bordered table table-hover',
		-style=>'text-align:center; max-width: 600px; margin-left:auto; margin-right:auto;',
	);

  $table -> addRow("Flags", @flags);
  $table -> setRowClass(1, 'active');
  $table -> addRow("Time (s)", @time_values);
  $table -> addRow("GPU (J)", @gpu_values);
  $table -> addRow("Memory (J)", @memory_values);
  $table -> addRow("CPU (J)", @cpu_values);

	#
	# GRAFICO
	#
	my $chart = Chart::Gnuplot->new(
	    output  => "charts/$prog.png",
	    title   => 'Consumption Values',
	    xlabel  => "Flags",
	    ylabel  => 'Energy (J)',
	    y2label => 'Time (s)',
	    bg      => { 
			 color   => "#c9c9ff", 
			 density => 0.2 
	   	},
	   	grid    => "on",
	   	bmargin => 6,
	    legend  => {
        position => "outside center bottom",
        order    => "horizontal reverse",
        width  => 2,
        height => 0.5,
        border   => 'on',
    	},
	    yrange  => [0, $max_energy+$max_energy*0.10],
	    y2range => [0, $max_time+$max_time*0.10],
	    xtics   => { mirror => 'off' },
	    ytics   => { mirror => 'off' },
	    y2tics  => 'on',
	    "style histogram" => "rowstacked",
	);

	my $cpu_bar = Chart::Gnuplot::DataSet->new(
	    xdata => \@flags,
	    ydata => \@cpu_values,
	    title => "CPU",
	    color => "#ff0000",	    
	    fill  => {density => 0.2},
	    style => "histograms",
	);

	my $memory_bar = Chart::Gnuplot::DataSet->new(
	    xdata => \@flags,
	    ydata => \@memory_values,
	    title => "MEMORY",
	    color => "#525bc3",
	    fill  => {density => 0.2},
	    style => "histograms",
	);

	my $gpu_bar = Chart::Gnuplot::DataSet->new(
	    xdata => \@flags,
	    ydata => \@gpu_values,
	    title => "GPU",
	    color => "#00b300", 
	    fill  => {density => 0.2},
	    style => "histograms",
	);

	my $time_line = Chart::Gnuplot::DataSet->new(
	  xdata  => \@time_values,
		ydata  => \@flags,
	  style  => 'lines',
	  color => "#000000",
	  title  => "TIME",
	  axes   => 'x1y2',
	);

	$chart->plot2d($cpu_bar, $memory_bar, $gpu_bar, $time_line);

	
	#HTML
	
	my $header = 
	"<!DOCTYPE html>
	<html>
		<head>
			<link href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css' rel='stylesheet'>
			<script src='https://code.jquery.com/jquery-2.1.3.min.js'></script>
			<script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js'></script>
			<title>$prog</title>
		</head>";
	my $body =
	"<body>
		<div class='container' style = 'margin-top: 20px'>
		<h2 style ='text-align: center'>$prog</h2>";
	my $img = "</div>
	<div >
		<img src=\"$prog.png\" style='display: block; margin-left: auto; margin-right: auto;'>
	</div>";
	my $footer = "</body><html>";

	my $html_file = "charts/$prog.html";
	open(my $fh, '>', $html_file) or die "Could not open file '$html_file' $!";
	print $fh $header, $body, $table->getTable, $img, $footer;
	close $fh;
}


#
# Sort by Values
#
mkdir "values" unless(-d "values");	
for my $prog (@folders_progs) {

	chomp $prog;
	
	my %prog_hash = ();
	my %time_hash = ();
	my %cpu_hash = ();
	my %gpu_hash = ();
	my %memory_hash = ();


	for my $flag (sort keys %{$info{$prog}}) {
		$prog_hash{$flag}{time} = $info{$prog}{$flag}{time_mean};
		$prog_hash{$flag}{cpu} = $info{$prog}{$flag}{cpu_mean};
		$prog_hash{$flag}{gpu} = $info{$prog}{$flag}{gpu_mean};
		$prog_hash{$flag}{memory} = $info{$prog}{$flag}{memory_mean};
	}

	open(my $fh, '>', "values/".$prog.".txt") or die "Could not open file '$prog' $!";
	print $fh "$prog\n";

	print $fh "\tSort by Time\n";
	for my $flag (sort {$prog_hash{$a}{time} <=> $prog_hash{$b}{time}} keys %prog_hash) {
		print $fh "\t\t".$flag.": ".  $prog_hash{$flag}{time}."\n";
	}

	print $fh "\n\tSort by CPU\n";	
	for my $flag (sort {$prog_hash{$a}{cpu} <=> $prog_hash{$b}{cpu}} keys %prog_hash) {
		print $fh "\t\t".$flag.": ".  $prog_hash{$flag}{cpu}."\n";
	}

	print $fh "\n\tSort by Memory\n";	
	for my $flag (sort {$prog_hash{$a}{memory} <=> $prog_hash{$b}{memory}} keys %prog_hash) {
		print $fh "\t\t".$flag.": ".  $prog_hash{$flag}{memory}."\n";
	}

	print $fh "\n\tSort by GPU\n";	
	for my $flag (sort {$prog_hash{$a}{gpu} <=> $prog_hash{$b}{gpu}} keys %prog_hash) {
		print $fh "\t\t".$flag.": ".  $prog_hash{$flag}{gpu}."\n";
	}

	print $fh "\n\n";
}
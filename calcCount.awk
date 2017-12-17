#
# Skip Header
#
/^##/		{ next
}
#
# Collect sample names
#
/^#CHROM/	{ for(i=10; i<= NF; i++) printf("\t%s\t%s\t%s", $i"_DP", $i"_AO", $i"_%%")
		  print ""
		  next
}
#
# Parse FORMAT field
# Select: DP, AO, RO fields
#
		{ split($9, format, ":")
		  dp = ao = ro = 0
		  for(i in format) {
		    if( format[i]=="DP" ) dp = i
		    if( format[i]=="AO" ) ao = i
		    if( format[i]=="RO" ) ro = i
		  }

#
# Print calculation
#
		  if( dp*ao*ro > 0 )
		    for(i=10; i<= NF; i++) {
		      split($i, counts, ":")
		      printf("\t%i\t%i\t%5.2f", counts[dp], counts[ao], counts[ao]/(counts[ao]+counts[ro])*100)
		    }
		  else 
		    for(i=10; i<= NF; i++) printf("\tNA\tNA\tNA")
		  print ""

}

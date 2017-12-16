BEGIN	{  FS = "|"
	  maxRank = 0
	  impact = variant = "NA"
}
	{ rank = index("MODIFIER LOW MODERATE HIGH ", $3)
	  if( rank>maxRank ) {
	    maxRank = rank
	    impact = $3
	    variant = $2
	  }
}
END	{ print impact"\t"variant
}

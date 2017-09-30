#!/usr/bin/perl -w

# written by Emmeline Pearson - z5178618 - Sep/Oct 2017

while ($line = <>) {
    if ($line =~ /^#!/ && $. == 1) {

        # translate #! line

        print "#!/usr/bin/perl -w\n";

    } 
    elsif ($line =~ /^\s*(#|$)/) {
        # Blank & comment lines can be passed unchanged
        print $line;

    } 
    elsif ($line =~ /^\s*print\("(.*)"\)/) {
        #have to add new line
	print "print \" $1 \\n \"\; \n"; 

    } 
	
    elsif($line =~ /while.*$/){
     #checking for while loops 
	chomp $line; 
	my @loops = split /:/,$line; 
	my $condition = $loops[0];
	$condition =~ s/while//; 
	$condition =~ s/ /\$/;
	print "while \($condition\)\{\n"; 
	$loops[1] =~ s/ //;
	my @loop2 = split /;/,$loops[1]; 
	
        for $item(@loop2){
	 if ($item =~ /^\s*print\([A-Za-z]*\)/) {
	 chomp $item; 
	 $item =~ s/print//;
	 $item =~ s/\(//;
	 $item =~ s/\)//;
	 $item = "\$".$item;
	 print "print \"$item\\n\"\;\n"; 

         } 
         elsif ($item =~ /[a-zA-Z0-9].* = [A-Za-z0-9].* [\*\+\-\/\%] [A-Za-z0-9].*/) {
         # variable assignment with operation in it 
	 chomp $item; 
         my @vars2 = split / /,$item; #setup var 1 = variable2 operation varaible 3 
         
	   foreach $var(@vars2){ 
		if($var =~ /[\*\+\-\/\%=]/){ 
		print" $var ";
		}
		elsif($var =~ /^\s*[0-9]/){ 
		print " $var"; 
		}
		else{
		  print"\$$var";
		}
	   }
	   print";\n"; #add semi colon to end of line 


        }
        }
       print "\}\n";
    }
    elsif($line =~ /if.*$/){
     #checking for if loops 
	chomp $line; 
	my @loops = split /:/,$line; 
	my $condition = $loops[0];
	$condition =~ s/if//; 
	$condition =~ s/ /\$/;
	print "if \($condition\)\{\n"; 
	$loops[1] =~ s/ //;
	my @loop2 = split /;/,$loops[1]; 
	
        for $item(@loop2){
	 if ($item =~ /^\s*print\([A-Za-z]*\)/) {
	 chomp $item; 
	 $item =~ s/print//;
	 $item =~ s/\(//;
	 $item =~ s/\)//;
	 $item = "\$".$item;
	 print "print \"$item\\n\"\;\n"; 

         } 
         elsif ($item =~ /[a-zA-Z0-9].* = [A-Za-z0-9].* [\*\+\-\/\%] [A-Za-z0-9].*/) {
         # variable assignment with operation in it 
	 chomp $item; 
         my @vars2 = split / /,$item; #setup var 1 = variable2 operation varaible 3 
         
	   foreach $var(@vars2){ 
		if($var =~ /[\*\+\-\/\%=]/){ 
		print" $var ";
		}
		elsif($var =~ /^\s*[0-9]/){ 
		print " $var"; 
		}
		else{
		  print"\$$var";
		}
	   }
	   print";\n"; #add semi colon to end of line 


        }
        }
       print "\}\n";
    }


    elsif ($line =~ /[a-zA-Z0-9].* = [A-Za-z0-9].* [\*\+\-\/\%] [A-Za-z0-9].*/) {
        # variable assignment with operation in it 
	chomp $line; 
        my @vars = split / /,$line; #setup var 1 = variable2 operation varaible 3 
       
	foreach $variable(@vars){
		if($variable =~ /[\*\+\-\/\%=]/){ 
		print" $variable ";
		}
		elsif($variable =~ /^\s*[0-9]/){ 
		print " $variable"; 
		}
		else{
		  print"\$$variable";
		}
	}
	print";\n"; #add semi colon to end of line 


    }
    elsif ($line =~ /^\s*[A-Za-z0-9]* = [0-9].*/){
        #variables     
	chomp $line; 
	print ("\$$line\; \n"); 

    } 
  
     #print statement for a variable 
    elsif ($line =~ /^\s*print\([A-Za-z]*\)/) {
	chomp $line; 
	$line =~ s/print//;
	$line =~ s/\(//;
	$line =~ s/\)//;
	$line = "\$".$line;
	print "print \"$line\\n\"\;\n"; 

    } 
    

	 #print statement with a variables & an operation 
	#will break if there are more than two things being added 
    elsif ($line =~ /^\s*print\([A-Za-z].* [\*\+\-\/\%] [A-Za-z].*\)/ ) {
        chomp $line; 
	$line =~ s/print//;
	$line =~ s/\(//;
	$line =~ s/\)//;
        my @vars = split / /,$line; #setup variable1 operation varaible 2 operation etc.
        print "print "; 
	
	foreach $variable(@vars){
		if($variable =~ /[\*\+\-\/\%]/){ 
		print" $variable ";
		}
		elsif($variable =~ /^\s*[0-9]/){ 
		print " $variable"; 
		}
		else{
		  print"\$$variable";
		}
	}
	print", \"\\n\";\n"; #add new line character and semicolon 
    } 
   

    else {

        # Lines we can't translate are turned into comments

        print "#$line\n";
    }
}

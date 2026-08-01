use strict directive to a selection of programs that you have
written. What effect does the addition of the directive have?
2. Write a one-liner that scans a disk-file for any blank lines, printing the words
''Got one!'' as soon as a blank line is found.
3. Write a program to do the same thing as the one-liner from the last question.
4. Can grep be used to perform the same task as the one-liner? Why or why
not?
5. Write a program that invokes the ls utility in long format, captures its
output, then displays a total count for the number of bytes in all of the
listed disk-files.
6. Write a program that writes another program, then uses eval to execute it.
7. Change the sortexamples program to sort the @chromosomes array alpha-
numerically, both in ascending and descending order. That is, given the
following list of values: 17, 5, 13, 21, 1, 2, 22 and 15, your program should
produce ''1 13 15 17 2 21 22 5'' and ''5 22 21 2 17 15 13 1''.
8. Consider the following HTML:
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="content-type"
content="text/html; charset=ISO-8859-1">
<title>Check out this great resource!</title>
</head>

Perl Grabbag
<body>
A great introduction to Bioinformatics Computing Skills and Practice is
to be had by reading <i>Bioinformatics, Biocomputing and Perl</i> by
Michael Moorhouse and Paul Barry, published by Wiley, 2004.
<p> Check out the book's web-site <a
href="http://glasnost.itcarlow.ie/~biobook/index.html">here</a>. </p>
</body>
</html>
Write a program using print statements to produce the above HTML
exactly as shown. Write a second program to do the same thing using a
HERE document. Which technique do you prefer?
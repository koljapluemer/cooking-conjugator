- implement mechanism for users to give feedback
- remove dead code
- check all files for insufficient inline-comments
- refactor 1 function
- think about accessibility strategies
- think about SEO strategies

- delete sushi at some point (or move it back to start)

- fix:
	- "I(m) am wanting is broken"


- diacritic removal also removes the doubled-letter-thingie
	- araby probably has options for that...


- I figured it out. *every* Ain is creating problems :)
	- no. It's standalone short vowels, floating in the void. Maybe?
		- aaah.
	- for now, "checked" is fucked. see if fixing in the script now helped it or not at some point
- "need" is definitely just fucked, even the base form....
	- ok, need was fucked because it was "need to" and included "li" in the base...
	- yes, core data problem: the short vowels (often? always?) come with added spaces, which are there the whole time...

- todo: fix verb forms that are automatically correct


- new approach:
	1. standardize the into, have a list. i know what it should be for every single form.
	2. see if the intro cannot be clearly detected. In that case, throw an alert and skip the form. It's fucked.
	3. if we *can* detect the intro, simply rip it out of the string and MERGE the fucking rest, it *must* be one verb

import urllib2, re

url = 'http://www.pythonchallenge.com/pc/def/linkedlist.php?nothing='
nothing = '67753'
i=0
while i <= 400:
	content = urllib2.urlopen(url+nothing).read()
	nothing = content.split("is ")[1]
	print nothing
	i+=1
print content
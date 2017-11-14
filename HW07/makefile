
all:	STAT545-HW07-Step1.html STAT545-HW07-Step2.html STAT545-HW07-Step3.html

clean:
	del -f STAT545-HW07-Step1.html STAT545-HW07-Step2.html STAT545-HW07-Step3.html
	
UNdata_Export_ALL_Factors.xls:
	curl -o  internet.usage.xls https://github.com/Shirlett/STAT545-hw-Hall-Shirlett/blob/master/HW07/UNdata_Export_ALL_Factors.xls

STAT545-HW07-Step1.html: UNdata_Export_ALL_Factors.xls
	Rscript -e 'rmarkdown::render("STAT545-HW07-Step1.R")'

STAT545-HW07-Step2.html: STAT545-HW07-Step1.html
	Rscript -e 'rmarkdown::render("STAT545-HW07-Step2.R")'

STAT545-HW07-Step3.html:	STAT545-HW07-Step2.html
	Rscript -e 'rmarkdown::render("STAT545-HW07-Step3.R")'
	
	
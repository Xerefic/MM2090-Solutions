ifndef MODPERIOD
	MODPERIOD=5
endif

DATE=`date | cut -d " " -f 2,3,4 | sed 's/ //g'`

default:
	@echo
	@echo "Usage: make list"
	@echo "\tList the changes made in the files of this directory in the last $(MODPERIOD) days"
	@echo
	@echo "Usage: make backup"
	@echo "\tAutomatically backup all the files of this directory"
	@echo

list:
	@find $(pwd) -mtime -$(MODPERIOD) -ls

backup:
	@rm -f backup$(DATE).tar
	@rm -rf ~/backup/backup$(DATE)/
	@mkdir ~/backup/backup$(DATE)
	@chmod 777 ~/backup/backup$(DATE)/

	@cp -r `find $(pwd) -mtime -$(MODPERIOD)` ~/backup/backup$(DATE)/
	@cp -r ~/backup/backup$(DATE)/ ./backup$(DATE)/
	@rm -r ~/backup/backup$(DATE)/	

	@tar cvfz backup-$(DATE).tar.gz backup$(DATE)/

	@rm -r ./backup$(DATE)/ 

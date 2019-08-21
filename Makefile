

OS=$(shell uname -s)

ifeq ($(OS),Darwin)
	ECHO=echo
endif

ECHO?=echo -e

.PHONY: lab rebuild clean rebuild-client status check update


usage:
	@$(ECHO)
	@$(ECHO) " USAGE:"
	@$(ECHO) "\t\t\tmake <target> where <target> is one of the following:"
	@$(ECHO)
	@$(ECHO) " TARGETS:"
	@$(ECHO)
	@$(ECHO) " lab\t\t\tBuilds 1 FreeIPA VM and 1 client VM."
	@$(ECHO)
	@$(ECHO) " rebuild\t\tFirst destroys all VMS, then builds 1 FreeIPA VM and 1 client VM."
	@$(ECHO) 
	@$(ECHO) " clean\t\t\tDestroys all VMs."
	@$(ECHO) 
	@$(ECHO) " rebuild-client\t\tFirst destroys the client VM, then rebuilds it."
	@$(ECHO)
	@$(ECHO) " status\t\t\tDisplays current status of the vagrant environment."
	@$(ECHO)
	@$(ECHO) " check\t\t\tChecks for outdated boxes."
	@$(ECHO)
	@$(ECHO) " update\t\t\tUpdates the box that is in use in the current Vagrant environment."
	@$(ECHO)


lab:
	@vagrant up ipa server1

rebuild: clean lab

clean:
	@vagrant destroy --force

status:
	@vagrant status

rebuild-client:
	vagrant destroy --force server1
	sleep 1
	vagrant up server1

check:
	@vagrant box outdated
update:
	@vagrant box update

MAKEFLAGS = -s

VLIB = vlib
VLOG = vlog
VSIM = vsim
VCOM = vcom

ifndef TESTNAME
TESTNAME = base_test
endif

ifndef SEED
SEED := $$(date +%N)
endif

ifdef VRF_FILE_LIST
F_LIST_TB = -f $(VRF_FILE_LIST)
endif

ifdef DUT_FILE_LIST
F_LIST_DUT = -f $(DUT_FILE_LIST)
endif


ifeq ($(GUI), 1)
	RUNC = 
else
	RUNC = -c -onfinish exit -do "run -all; quit"
endif

######################################
# COMP/SIM Preparation
######################################
ifndef COMP_DIR
COMP_DIR = build_default
endif

ifndef SIM_DIR
SIM_DIR = $(TESTNAME)_sim
endif

ifndef LIB_NAME
LIB_NAME = modelsim
endif

ifndef TOP
TOP = top
endif

export BUILD_PATH=$(PROJ)/work/run/$(COMP_DIR)
export SIM_PATH=$(PROJ)/work/run/$(SIM_DIR)
######################################
# Targets
######################################

.PHONY: help all clean clean_sim clean_all run comp $(SIM_DIR) $(COMP_DIR)

help :
	@echo ""
	@echo "Help for Modelsim's Makefile:"
	@echo "Use: make [commands] [defines]"
	@echo "1. Make file support next commands:"
	@echo "	all/run	- for compil, elobarate, and start simulation"
	@echo "	clean	- for deleting $(COMP_DIR)"
	@echo "	help	- Makefile help"
	@echo ""
	@echo "2. Makefile suppot next deffines:"
	@echo "	RUN_OPTS - use for adding fallow run options:"
	@echo "		-gui         Invoke the Graphical User Interface"
	@echo "	For more information use 'xrun -help'"
	@echo ""
	@echo "3. Examples:"
	@echo "	make clear"
	@echo "	make all runn RUN_OPTS+='-gui'"
	@echo "	make clean_all"
	@echo ""
	exit 0

comp: $(COMP_DIR)
	cd $(COMP_DIR); \
	$(VLOG) -work $(LIB_NAME) \
			-sv \
			$(F_LIST_DUT)

run: $(SIM_DIR)
	cd $(SIM_DIR); \
	$(VSIM) $(RUNC) \
		$(BUILD_PATH)/$(LIB_NAME).$(TOP) \
		$(RUN_OPTS)
		


clean:
	@if [ -d $(COMP_DIR) ]; then \
		rm -rf $(COMP_DIR); \
		echo "$(COMP_DIR) was delete..."; \
	fi

clean_sim:
	@rm -rf ./*_sim
	@echo "All Sim dirs were delete..."

clean_all: clean clean_sim


$(COMP_DIR):
	@if [ ! -d $(COMP_DIR) ]; then \
		mkdir $(COMP_DIR);	\
	fi

$(SIM_DIR):
	@if [ ! -d $(SIM_DIR) ]; then \
		mkdir $(SIM_DIR);	\
	fi

# Fortran compiler. Only gfortran is compatible with the flags used here and
# the cross-platform build environments in Travis CI. Specifically, the
# invocation via gcc is due to an issue with static linking on macOS.
FC = gcc

FLAGS = -c -O2 -v
# -mcmodel=medium
# option for gfortran
# allows handling of a larger number of MEP on 64 bit system
# FLAGS = -c -mcmodel=medium -O2

OBJS= resp.o
SRCS= resp.f
LIB= shared_variables.h

vpath %.a $(VPATH_DIR)
.LIBPATTERNS = lib%.a lib%.dylib lib%.so

STATICLIBS = -lgfortran -lquadmath

resp:	$(OBJS) $(STATICLIBS)
	# Based on: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=46539#c3
	# and https://stackoverflow.com/a/5583245
	$(FC) $^ -lm -o resp

$(OBJS): $(SRCS) $(LIB)
	$(FC) $(FLAGS) $(SRCS)

clean:
	rm -rf $(OBJS) resp


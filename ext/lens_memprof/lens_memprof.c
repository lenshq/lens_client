#include "ruby.h"
#include "ruby/intern.h"

/*
 * Debugger for VALUE
 *
static void d(VALUE v) {
    ID sym_puts = rb_intern("puts");
    ID sym_inspect = rb_intern("inspect");
    rb_funcall(rb_mKernel, sym_puts, 1, rb_funcall(v, sym_inspect, 0));
}
*/

/*
 * Count of RUBY_INTERNAL_EVENT_NEWOBJ events
 * */
typedef struct lens_allocations_struct {
   uint64_t count;
} lens_allocations_t;

/*
 * Use TLS for storing allocations info
 * More info: https://gcc.gnu.org/onlinedocs/gcc-3.4.1/gcc/Thread-Local.html
 * */
static __thread lens_allocations_t lens_allocations;

static inline lens_allocations_t* allocations() { return &lens_allocations; }

void lens_memory_increment(rb_event_flag_t flag, VALUE node, VALUE self, ID mid, VALUE klass) {
  (void)(flag); (void)(node); (void)(self); (void)(mid); (void)(klass);
  allocations()->count++;
}

void lens_activate_memprof() {
  rb_add_event_hook(lens_memory_increment, RUBY_INTERNAL_EVENT_NEWOBJ, Qnil);
}

void lens_deactivate_memprof() {
  rb_remove_event_hook(lens_memory_increment);
}

static VALUE start() {
  lens_activate_memprof();
  return Qnil;
}

static VALUE stop() {
  lens_deactivate_memprof();
  return Qnil;
}

static VALUE reset() {
  allocations()->count = 0;
  return Qnil;
}

/*
 * Initialize on require
 * */
void Init_lens_memprof();
VALUE get_allocations_count(VALUE self);

void Init_lens_memprof()
{
  VALUE CMemProf = rb_define_module("LensCMemprof");
  rb_define_method(CMemProf, "allocations", get_allocations_count, 0);
  rb_define_method(CMemProf, "start", start, 0);
  rb_define_method(CMemProf, "reset", reset, 0);
  rb_define_method(CMemProf, "stop", stop, 0);
}

VALUE get_allocations_count(VALUE self)
{
  return UINT2NUM(allocations()->count);
}

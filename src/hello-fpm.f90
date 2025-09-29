module hello_fpm
  implicit none
  private

  public :: say_hello
contains
  subroutine say_hello
    print *, "Hello, hello-fpm!"
  end subroutine say_hello
end module hello_fpm

program codeAUSM
  !
  ! Implementation of AUSM+ for 1D Euler equations
  ! @pcorreia
  !
  use m_init
  
  implicit none

  integer :: i

  call initialization()

  do i = 1,  niter ! iteration in time
     call ausm()
     call update()
  end do

  call output()

  print *, '** The end **'

end program codeAUSM
